//
//  ForgotPasswordView.swift
//  Project24
//
//  Created by Divyachenduran A on 12/7/24.
//
import UIKit

class ForgotPasswordView: UIView {
    let emailTextField = UITextField()
    let sendEmailButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    private func setupUI() {
        // Configure email text field
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)

        // Configure send email button
        sendEmailButton.setTitle("Send Reset Email", for: .normal)
        sendEmailButton.backgroundColor = .systemBlue
        sendEmailButton.setTitleColor(.white, for: .normal)
        sendEmailButton.layer.cornerRadius = 10
        sendEmailButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendEmailButton)

        // Add constraints
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            sendEmailButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            sendEmailButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sendEmailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
