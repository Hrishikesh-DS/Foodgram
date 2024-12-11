//
//  HomeViewController.swift
//  Project24
//
//  Created by Suraj Mishra on 12/4/24.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    var recipes: [Recipe] = []
    private let db = Firestore.firestore()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FoodGram"
        self.homeView.tableView.reloadData()
        setupTableView()
        setupNavigationBar()
        fetchRecipes()
    }
    
    private func setupNavigationBar() {
        // Profile Button
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
        profileButton.tintColor = .systemBlue

        // Add Recipe Button
        let addRecipeButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .plain,
            target: self,
            action: #selector(addRecipeButtonTapped)
        )
        addRecipeButton.tintColor = .systemBlue
        
        // Power Button (Logout)
        let logoutButton = UIBarButtonItem(
            image: UIImage(systemName: "power"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
        logoutButton.tintColor = .systemRed

        navigationItem.rightBarButtonItems = [profileButton, addRecipeButton]
        navigationItem.leftBarButtonItem = logoutButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes() // Reload recipes whenever the view appears
    }
    
    @objc private func profileButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func addRecipeButtonTapped() {
        let addRecipeVC = AddRecipeViewController()
        navigationController?.pushViewController(addRecipeVC, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            // Navigate back to the login screen
            let loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Failed to sign out: \(error)")
        }
    }
    
    private func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
    }

    private func fetchRecipes() {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            }
            self.recipes = snapshot?.documents.compactMap { doc in
                return Recipe(id: doc.documentID, data: doc.data())
            } ?? []
            DispatchQueue.main.async {
                self.homeView.tableView.reloadData()
            }
        }
    }
}

