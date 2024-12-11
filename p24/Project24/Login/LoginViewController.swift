//
//  LoginViewController.swift
//  Project24
//
//  Created by Hrishikesh D S on 24/11/24.
//final

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActions()
    }
     
    private func setupActions() {
        // Add button actions
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.registerLabelButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(goToForgotPassword), for: .touchUpInside) // Added Forgot Password action
    }
    
    @objc private func loginTapped() {
        guard let email = loginView.emailTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        
        // Attempt Firebase login
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
            } else {
                // Successful login
                let homeVC = HomeViewController()
                self.navigationController?.setViewControllers([homeVC], animated: true)
            }
        }
    }
    
    @objc private func goToRegister() {
        // Navigate to Register screen
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func goToForgotPassword() {
        // Navigate to Forgot Password screen
        let forgotPasswordVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        // Helper function to show alerts
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
