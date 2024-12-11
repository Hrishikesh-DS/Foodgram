//
//  AddRecipeView.swift
//  Project24
//
//  Created by Hrishikesh D S on 5/12/24.
//

import UIKit

class AddRecipeView: UIView {

    let recipeImageView = UIImageView()
    let titleTextField = UITextField()
    let descriptionTextView = UITextView()
    let addButton = UIButton(type: .system)
    let changeImageButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRecipeImageView()
        setupChangeImageButton()
        setupTitleTextField()
        setupDescriptionTextView()
        setupAddButton()
        initConstraints()
    }

    func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.backgroundColor = .lightGray
        recipeImageView.isUserInteractionEnabled = true
        recipeImageView.layer.cornerRadius = 8
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipeImageView)
    }

    func setupChangeImageButton() {
        changeImageButton.setTitle("Change Image", for: .normal)
        changeImageButton.backgroundColor = .systemGray
        changeImageButton.setTitleColor(.white, for: .normal)
        changeImageButton.layer.cornerRadius = 8
        changeImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(changeImageButton)
    }

    func setupTitleTextField() {
        titleTextField.borderStyle = .roundedRect
        titleTextField.placeholder = "Enter recipe title"
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleTextField)
    }

    func setupDescriptionTextView() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionTextView)
    }

    func setupAddButton() {
        addButton.setTitle("Add Recipe", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addButton)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 150),
            recipeImageView.heightAnchor.constraint(equalToConstant: 150),

            changeImageButton.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 10),
            changeImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            changeImageButton.widthAnchor.constraint(equalToConstant: 120),
            changeImageButton.heightAnchor.constraint(equalToConstant: 30),

            titleTextField.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),

            addButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureImagePicker(target: UIViewController, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        recipeImageView.addGestureRecognizer(tapGesture)
        changeImageButton.addTarget(target, action: action, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
