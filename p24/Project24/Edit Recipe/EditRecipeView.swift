//
//  EditRecipeView.swift
//  Project24
//
//  Created by Hrishikesh D S on 6/12/24.
//


import UIKit

class EditRecipeView: UIView {

    // MARK: - UI Components
    let recipeImageView = UIImageView()
    let titleTextField = UITextField()
    let descriptionTextView = UITextView()
    let saveButton = UIButton(type: .system)

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .white
        setupRecipeImageView()
        setupTitleTextField()
        setupDescriptionTextView()
        setupSaveButton()
    }

    private func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.backgroundColor = .lightGray
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recipeImageView)
    }

    private func setupTitleTextField() {
        titleTextField.placeholder = "Enter recipe title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleTextField)
    }

    private func setupDescriptionTextView() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
    }

    private func setupSaveButton() {
        saveButton.setTitle("Save Changes", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 150),
            recipeImageView.heightAnchor.constraint(equalToConstant: 150),

            titleTextField.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),

            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Public Methods
    func configureSaveButton(target: Any, action: Selector) {
        saveButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
