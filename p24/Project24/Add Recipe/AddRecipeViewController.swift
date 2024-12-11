import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import FirebaseAuth

class AddRecipeViewController: UIViewController {

    private let addRecipeView = AddRecipeView()
    private var pickedImage: UIImage?

    override func loadView() {
        view = addRecipeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Recipe"
        view.backgroundColor = .white

        // Add gesture and button actions
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        addRecipeView.recipeImageView.addGestureRecognizer(tapGesture)
        addRecipeView.addButton.addTarget(self, action: #selector(addRecipeTapped), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc private func addRecipeTapped() {
        guard let userId = Auth.auth().currentUser?.uid else {
            showAlert(message: "User not logged in.")
            return
        }
        guard let title = addRecipeView.titleTextField.text, !title.isEmpty,
              let description = addRecipeView.descriptionTextView.text, !description.isEmpty,
              let image = pickedImage else {
            showAlert(message: "Please fill all fields and add an image.")
            return
        }

        uploadImage(image: image) { [weak self] imageUrl in
            guard let self = self, let imageUrl = imageUrl else {
                self?.showAlert(message: "Image upload failed.")
                return
            }
            self.saveRecipeToFirestore(userId: userId, title: title, description: description, imageUrl: imageUrl)
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

    private func saveRecipeToFirestore(userId: String, title: String, description: String, imageUrl: String) {
        let db = Firestore.firestore()
        let recipesCollection = db.collection("recipes")

        let newRecipe: [String: Any] = [
            "title": title,
            "description": description,
            "userId": userId,
            "imageName": imageUrl,
            "likedBy": []
        ]

        recipesCollection.document(title).setData(newRecipe) { [weak self] error in
            if let error = error {
                self?.showAlert(message: "Error saving recipe: \(error.localizedDescription)")
            } else {
                self?.showAlert(message: "Recipe added successfully!", dismissAfter: true)
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

    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
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

    private func showAlert(message: String, dismissAfter: Bool = false) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        if dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
extension AddRecipeViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.addRecipeView.recipeImageView.image = image
                        self?.pickedImage = image
                    }
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let image = info[.editedImage] as? UIImage {
            addRecipeView.recipeImageView.image = image
            pickedImage = image
        }
    }
}
