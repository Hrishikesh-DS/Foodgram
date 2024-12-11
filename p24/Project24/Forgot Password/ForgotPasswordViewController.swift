//
//  ForgotPasswordViewController.swift
//  Project24
//
//  Created by Divyachenduran A on 12/7/24.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    private let forgotPasswordView = ForgotPasswordView()

    override func loadView() {
        self.view = forgotPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forgot Password"
        view.backgroundColor = .white
        setupActions()
    }

    private func setupActions() {
        forgotPasswordView.sendEmailButton.addTarget(self, action: #selector(sendResetEmailTapped), for: .touchUpInside)
    }

    @objc private func sendResetEmailTapped() {
        guard let email = forgotPasswordView.emailTextField.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email.")
            return
        }

        // Send password reset email
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self?.showAlert(title: "Success", message: "Password reset email sent. Please check your inbox.") {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
