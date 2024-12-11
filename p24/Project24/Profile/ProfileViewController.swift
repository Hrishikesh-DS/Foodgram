//
//  ProfileViewController.swift
//  Project24
//
//  Created by Divyachenduran A on 11/21/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        profileView.backgroundColor = .white
        fetchUserData() // Fetch current user's data
    }
    
    private func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            showAlert(title: "Error", message: "Failed to fetch user data.")
            return
        }
        
        // Fetch user data from UserDefaults using `uid`
        if let userData = UserDefaults.standard.dictionary(forKey: "user_\(userId)") as? [String: String] {
            let name = userData["name"] ?? "No Name"
            let email = userData["email"] ?? "No Email"
            
            DispatchQueue.main.async {
                self.profileView.nameField.text = name
                self.profileView.emailField.text = email
            }
        } else {
            showAlert(title: "Error", message: "No user data found.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
