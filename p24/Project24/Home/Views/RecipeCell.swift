//
//  RecipeCell.swift
//  Project24
//
//  Created by Suraj Mishra on 12/4/24.
//

import UIKit

class RecipeCell: UITableViewCell {
    private let recipeCellView = RecipeCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recipeCellView)

        recipeCellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with recipe: Recipe) {
        recipeCellView.recipeTitleLabel.text = recipe.title

        loadImage(from: recipe.imageName) { [weak self] image in
            DispatchQueue.main.async {
                self?.recipeCellView.recipeImageView.image = image ?? UIImage(named: "placeholder")
            }
        }
    }


    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Perform asynchronous network call
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            // Return the image
            completion(image)
        }.resume()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
