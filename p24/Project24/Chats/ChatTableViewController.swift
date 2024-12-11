//
//  ChatTableViewController.swift
//  Project24
//
//  Created by Hrishikesh D S on 25/11/24.
//

import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BubbleCell", for: indexPath) as! BubbleTableViewCell
        let message = messages[indexPath.row]
        
        // Configure the cell
        cell.configure(with: message, cellWidth: tableView.frame.width)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
