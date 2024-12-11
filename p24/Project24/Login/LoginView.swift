//
//  LoginView.swift
//  Assignment8Grp24
//
//  Created by Hrishikesh D S on 10/11/24.
//

import UIKit

class LoginView: UIView {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let registerLabelButton = UIButton(type: .system)
    let forgotPasswordButton = UIButton(type: .system) // Added forgot password button
    let appTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        setupForgotPasswordButton() // Setup for forgot password button
        initConstraints()
    }
    
    private func setupAppTitleLabel() {
        appTitleLabel.text = "FoodGram"
        appTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        appTitleLabel.textAlignment = .center
        appTitleLabel.textColor = .systemBlue
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(appTitleLabel)
    }

    private func setupEmailTextField() {
        emailTextField.placeholder = "Enter Email"
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordTextField)
    }
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginButton)
    }
    
    private func setupRegisterButton() {
        registerLabelButton.setTitle("Don't have an account? Register", for: .normal)
        registerLabelButton.setTitleColor(.systemBlue, for: .normal)
        registerLabelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(registerLabelButton)
    }
    
    private func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forgotPasswordButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // App title label
            appTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            appTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            // Email text field
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 40),
            
            // Password text field
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            
            // Login button
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Forgot password button
            forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            
            // Register button
            registerLabelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerLabelButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
