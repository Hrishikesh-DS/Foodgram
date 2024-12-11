//
//  RegisterViewController.swift
//  Project24
//
//  Created by Divyachenduran A on 11/21/24.
//
//import UIKit
//import FirebaseAuth
//
//class RegisterViewController: UIViewController {
//    
//    let registerView = RegisterView()
//
//    override func loadView() {
//        view = registerView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Register"
//        registerView.registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
//    }
//
//
//
//    @objc private func registerUser() {
//        guard let name = registerView.nameField.text, !name.isEmpty,
//              let email = registerView.emailField.text, !email.isEmpty,
//              let password = registerView.passwordField.text, !password.isEmpty,
//              let reenteredPassword = registerView.reenterPasswordField.text, !reenteredPassword.isEmpty else {
//            showAlert(title: "Error", message: "Please fill all fields.")
//            return
//        }
//        
//        guard password == reenteredPassword else {
//            showAlert(title: "Error", message: "Passwords do not match.")
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
//            if let error = error {
//                self?.showAlert(title: "Error", message: error.localizedDescription)
//                return
//            }
//            
//            guard let userId = authResult?.user.uid else { return }
//            
//            // Save user data to UserDefaults using `uid` as a key
//            let userData = ["name": name, "email": email]
//            UserDefaults.standard.set(userData, forKey: "user_\(userId)")
//            
//            // Navigate to the login page
//            DispatchQueue.main.async {
//                self?.showAlert(title: "Success", message: "Registration successful! Please login.") {
//                    self?.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
//    }
//
//    
//    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//            completion?()
//        })
//        present(alert, animated: true)
//    }
//    
//    private func isValidEmail(_ email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        return emailPredicate.evaluate(with: email)
//    }
//}
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Register"
        
        // Attach actions to buttons
        registerView.registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        registerView.loginButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
    }

    // MARK: - Register User
    @objc private func registerUser() {
        guard let name = registerView.nameField.text, !name.isEmpty,
              let email = registerView.emailField.text, !email.isEmpty,
              let password = registerView.passwordField.text, !password.isEmpty,
              let reenteredPassword = registerView.reenterPasswordField.text, !reenteredPassword.isEmpty else {
            showAlert(title: "Error", message: "Please fill all fields.")
            return
        }
        
        guard password == reenteredPassword else {
            showAlert(title: "Error", message: "Passwords do not match.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(title: "Error", message: "Invalid email address.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            guard let userId = authResult?.user.uid else { return }
            
            // Save user data to UserDefaults using `uid` as a key
            let userData = ["name": name, "email": email]
            UserDefaults.standard.set(userData, forKey: "user_\(userId)")
            
            // Navigate to the login page
            DispatchQueue.main.async {
                self?.showAlert(title: "Success", message: "Registration successful! Please login.") {
                    self?.navigateToLogin()
                }
            }
        }
    }

    // MARK: - Navigate to Login
    @objc private func navigateToLogin() {
        let loginVC = LoginViewController() // Replace with your actual LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }

    // MARK: - Show Alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }

    // MARK: - Email Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
