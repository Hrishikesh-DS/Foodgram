//
//  ProfileView.swift
//  Project24
//
//  Created by Hrishikesh D S on 11/24/24.
//

import UIKit

class ProfileView: UIView {
    
    // Public access to the UI elements
    var profileImageView: UIImageView!
    var nameField: UITextField!
    var emailField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemGroupedBackground
        
        profileImageView = createProfileImageView()
        nameField = createNameField()
        emailField = createEmailField()
        
        addSubview(profileImageView)
        addSubview(nameField)
        addSubview(emailField)
        
        setupConstraints()
    }
    
    private func createProfileImageView() -> UIImageView {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        profileImageView.tintColor = .systemGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.systemBlue.cgColor
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }
    
    private func createNameField() -> UITextField {
        let nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.borderStyle = .roundedRect
        nameField.layer.cornerRadius = 10
        nameField.isEnabled = false // Disable editing
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }
    
    private func createEmailField() -> UITextField {
        let emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        emailField.layer.cornerRadius = 10
        emailField.isEnabled = false // Disable editing
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
