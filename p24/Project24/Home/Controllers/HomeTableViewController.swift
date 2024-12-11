//
//  Untitled.swift
//  Project24
//
//  Created by Hrishikesh D S on 5/12/24.
//
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = RecipeDetailsViewController()
        detailVC.recipe = recipes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
