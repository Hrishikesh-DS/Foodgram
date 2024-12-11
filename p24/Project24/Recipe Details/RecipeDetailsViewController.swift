//
//  RecipeDetailsViewController.swift
//  Project24
//
//  Created by Suraj Mishra on 12/4/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RecipeDetailsViewController: UIViewController {

    let recipeDetailsView = RecipeDetailsView()
    var recipe: Recipe?
    private let db = Firestore.firestore()

    override func loadView() {
        self.view = recipeDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = recipe?.title
        setupView()
        fetchLikes()
        checkIfRecipeBelongsToCurrentUser()
    }

    
    @objc private func chatGPTButtonTapped() {
        let chatVC = ChatViewController()
        chatVC.recipeDescription = recipe?.description
        navigationController?.pushViewController(chatVC, animated: true)
    }

    private func checkIfRecipeBelongsToCurrentUser() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let recipeUserId = recipe?.userId else { return } // Assuming `Recipe` model has a `userId` property

        if currentUserId == recipeUserId {
            let editButton = UIBarButtonItem(
                title: "Edit",
                style: .plain,
                target: self,
                action: #selector(editButtonTapped)
            )
            navigationItem.rightBarButtonItem = editButton
        }
    }
    
    @objc private func editButtonTapped() {
        guard let recipe = recipe else { return }
        let editRecipeVC = EditRecipeViewController()
        editRecipeVC.recipe = recipe
        navigationController?.pushViewController(editRecipeVC, animated: true)
    }
    
    private func setupView() {
        // Set the image
        loadImage(from: recipe?.imageName ?? "") { [weak self] image in
            DispatchQueue.main.async {
                self?.recipeDetailsView.recipeImageView.image = image
            }
        }
        // Set the title
        recipeDetailsView.recipeTitleLabel.text = recipe?.title
        recipeDetailsView.chatGPTButton.addTarget(self, action: #selector(chatGPTButtonTapped), for: .touchUpInside)
        recipeDetailsView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // Format the description
        if let description = recipe?.description {
            let formattedDescription = description.replacingOccurrences(of: "\\n", with: "\n")
            recipeDetailsView.descriptionLabel.text = formattedDescription
        }
    }
    
    @objc private func likeButtonTapped() {
        print("Recipe id: " + (recipe?.id ?? "Not found"))
        guard let recipeId = recipe?.id else { return }
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let recipeRef = db.collection("recipes").document(recipeId)

        recipeRef.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            // Check if the document exists
            guard let data = snapshot?.data() else {
                print("Recipe document not found.")
                return
            }

            // Get the `likedBy` field or initialize it as an empty array
            var likedBy = data["likedBy"] as? [String] ?? []

            if likedBy.contains(userId) {
                // Unlike
                likedBy.removeAll { $0 == userId }
            } else {
                // Like
                likedBy.append(userId)
            }

            // Update the Firestore document
            recipeRef.updateData(["likedBy": likedBy]) { error in
                if let error = error {
                    print("Error updating likedBy field: \(error)")
                    return
                }

                DispatchQueue.main.async {
                    // Update the UI after successfully updating Firestore
                    self.recipeDetailsView.likeCountLabel.text = "\(likedBy.count) Likes"
                    self.updateLikeButtonState(likedBy: likedBy)
                }
            }
        }
    }


    private func fetchLikes() {
        guard let recipeId = recipe?.id else { return }

        let db = Firestore.firestore()
        db.collection("recipes").document(recipeId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching likes: \(error)")
                return
            }

            guard let data = snapshot?.data(),
                  let likedBy = data["likedBy"] as? [String] else {
                self.recipeDetailsView.likeCountLabel.text = "0 Likes"
                return
            }

            DispatchQueue.main.async {
                self.recipeDetailsView.likeCountLabel.text = "\(likedBy.count) Likes"
                self.updateLikeButtonState(likedBy: likedBy)
            }
        }
    }
    
    private func updateLikeButtonState(likedBy: [String]) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if likedBy.contains(userId) {
            self.recipeDetailsView.likeButton.setTitle("Unlike", for: .normal)
        } else {
            self.recipeDetailsView.likeButton.setTitle("Like", for: .normal)
        }
    }


    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            completion(image)
        }
        task.resume()
    }

}
