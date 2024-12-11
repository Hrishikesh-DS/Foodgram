import UIKit

class RegisterView: UIView {

    let nameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let reenterPasswordField = UITextField()
    let registerButton = UIButton(type: .system)
    let loginButton = UIButton(type: .system) // Added login button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        // Configure text fields
        [nameField, emailField, passwordField, reenterPasswordField].forEach {
            $0.borderStyle = .roundedRect
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        nameField.placeholder = "Enter Name"
        emailField.placeholder = "Enter Email"
        emailField.keyboardType = .emailAddress
        passwordField.placeholder = "Enter Password"
        passwordField.isSecureTextEntry = true
        reenterPasswordField.placeholder = "Re-enter Password"
        reenterPasswordField.isSecureTextEntry = true
        
        // Configure register button
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
        
        // Configure login button
        loginButton.setTitle("Already have an account? Login", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            reenterPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            reenterPasswordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            reenterPasswordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            reenterPasswordField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: reenterPasswordField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
