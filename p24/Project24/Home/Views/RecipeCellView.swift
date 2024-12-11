//
//  RecipeCellView.swift
//  Project24
//

import UIKit

class RecipeCellView: UIView {

    let recipeImageView = UIImageView()
    let recipeTitleLabel = UILabel()
    private let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupRecipeImageView()
        setupRecipeTitleLabel()
        initConstraints()
    }
    
    func setupContainerView() {
        // Configure containerView
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 5
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
    }

    func setupRecipeImageView() {
        // Configure recipeImageView
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.clipsToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(recipeImageView)
    }

    func setupRecipeTitleLabel() {
        // Configure recipeTitleLabel
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        recipeTitleLabel.textColor = .black
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(recipeTitleLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            recipeImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),

            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 10),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            recipeTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
