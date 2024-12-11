import UIKit
import Alamofire

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    private let chatView = ChatView() // Use the custom ChatView
    var messages: [(role: String, content: String)] = [] // Stores messages as a tuple (role, content)
    var recipeDescription: String?
    var viewNewlyLoaded: Bool = false
    var messageAdded: Bool = false
    // MARK: - Lifecycle
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        chatView.blurEffectView.isHidden = true
        setupDelegates()
        setupSendButton()
        viewNewlyLoaded = true
        
        chatView.tableView.register(BubbleTableViewCell.self, forCellReuseIdentifier: "BubbleCell")
        
        // Only append the recipeDescription message once (if it's available)
        if let description = recipeDescription, viewNewlyLoaded {
            messages.append((role: "user", content: description))
            viewNewlyLoaded = false
            messageAdded = true
        }

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        // Add keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    // MARK: - Show/Hide Loader
    private func showLoader() {
        chatView.loader.startAnimating()
        chatView.blurEffectView.isHidden = false // Show the blur effect
    }
    
    private func hideLoader() {
        chatView.loader.stopAnimating()
        chatView.blurEffectView.isHidden = true // Hide the blur effect
    }

    // MARK: - Setup
    private func setupDelegates() {
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
        chatView.messageInputField.delegate = self
    }
    
    private func setupSendButton() {
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    // MARK: - Send Message Logic
    @objc private func sendMessage() {
        guard let message = chatView.messageInputField.text, !message.isEmpty else { return }

        // Add user's message to messages array and reload the table view
        messages.append((role: "user", content: message))
        chatView.tableView.reloadData()
        chatView.messageInputField.text = ""
        scrollToBottom()
        
        // Show loader
        showLoader()
        
        // Call ChatGPT API
        sendMessageToChatGPT(message: message) { [weak self] reply in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                // Hide loader once response is received
                self.hideLoader()
                if let reply = reply {
                    self.messages.append((role: "assistant", content: reply))
                } else {
                    self.messages.append((role: "assistant", content: "Error: Unable to parse response."))
                }
                self.chatView.tableView.reloadData()
                self.scrollToBottom()
            }
        }
        if(self.messageAdded){
            self.messageAdded = false
            self.chatView.tableView.isHidden = false
            self.messages.removeFirst()
        }
    }
    
    private func sendMessageToChatGPT(message: String, completion: @escaping (String?) -> Void) {
        let url = "https://api.openai.com/v1/chat/completions"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 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",
        ]
        let parameters: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": messages.map { ["role": $0.role, "content": $0.content] }
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        // Print raw response for debugging
                        print("Raw Response: \(String(data: data, encoding: .utf8) ?? "N/A")")
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [String: Any],
                           let choices = dict["choices"] as? [[String: Any]],
                           let message = choices.first?["message"] as? [String: Any],
                           let content = message["content"] as? String {
                            completion(content)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        print("Error while parsing JSON: \(error)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }
            }
    }

    
    private func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // MARK: Keyboard Handling
    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            // Move the chat view up by the keyboard's height
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Restore the chat view's original position
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
