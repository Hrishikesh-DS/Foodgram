import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import FirebaseAuth

class EditRecipeViewController: UIViewController {

    private let editRecipeView = AddRecipeView() // Reusing the same view as AddRecipeView
    var recipe: Recipe? // Pass the recipe object to edit
    private var pickedImage: UIImage?

    override func loadView() {
        view = editRecipeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Recipe"
        view.backgroundColor = .white

        // Set up existing recipe data
        populateExistingData()

        // Add gesture and button actions
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        editRecipeView.recipeImageView.addGestureRecognizer(tapGesture)
        editRecipeView.addButton.setTitle("Save Changes", for: .normal)
        editRecipeView.addButton.addTarget(self, action: #selector(updateRecipeTapped), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    private func populateExistingData() {
        guard let recipe = recipe else { return }
        editRecipeView.titleTextField.text = recipe.title
        editRecipeView.descriptionTextView.text = recipe.description

        // Load the existing recipe image
        loadImage(from: recipe.imageName) { [weak self] image in
            DispatchQueue.main.async {
                self?.editRecipeView.recipeImageView.image = image
            }
        }
    }

    @objc private func updateRecipeTapped() {
        guard let recipe = recipe,
              let title = editRecipeView.titleTextField.text, !title.isEmpty,
              let description = editRecipeView.descriptionTextView.text, !description.isEmpty else {
            showAlert(message: "Please fill all fields.")
            return
        }

        if let pickedImage = pickedImage {
            uploadImage(image: pickedImage) { [weak self] imageUrl in
                guard let self = self, let imageUrl = imageUrl else {
                    self?.showAlert(message: "Image upload failed.")
                    return
                }
                self.updateRecipeInFirestore(recipe: recipe, title: title, description: description, imageUrl: imageUrl)
            }
        } else {
            updateRecipeInFirestore(recipe: recipe, title: title, description: description, imageUrl: recipe.imageName)
        }
    }

    private func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        let storageRef = Storage.storage().reference().child("recipe_images/")
        let uniqueImageID = UUID().uuidString
        let imageRef = storageRef.child("\(uniqueImageID).jpg")

        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(url?.absoluteString)
            }
        }
    }

    private func updateRecipeInFirestore(recipe: Recipe, title: String, description: String, imageUrl: String) {
        let db = Firestore.firestore()
        let recipesCollection = db.collection("recipes")

        let updatedData: [String: Any] = [
            "title": title,
            "description": description,
            "imageName": imageUrl
        ]

        recipesCollection.document(recipe.id).updateData(updatedData) { [weak self] error in
            if let error = error {
                self?.showAlert(message: "Error updating recipe: \(error.localizedDescription)")
            } else {
                self?.showAlert(message: "Recipe updated successfully!", dismissAfter: true)
            }
        }
    }

    @objc private func selectImage() {
        let alertController = UIAlertController(title: "Select Image", message: "Choose a source", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.pickUsingCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.pickPhotoFromGallery()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }

    private func pickUsingCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(message: "Camera not available.")
            return
        }

        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }

    @objc private func hideKeyboardOnTap() {
        view.endEditing(true)
    }

    private func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        present(photoPicker, animated: true)
    }

    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    private func showAlert(message: String, dismissAfter: Bool = false) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        if dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true) {
                    self.navigationController?.setViewControllers([HomeViewController()], animated: true)
                }
            }
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
extension EditRecipeViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, _) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.editRecipeView.recipeImageView.image = image
                        self?.pickedImage = image
                    }
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let image = info[.editedImage] as? UIImage {
            editRecipeView.recipeImageView.image = image
            pickedImage = image
        }
    }
}
