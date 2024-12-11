//
//  HomeView.swift
//  Project24
//
//  Created by Suraj Mishra on 12/4/24.
//

import UIKit

class HomeView: UIView {
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        initConstraints()
        self.backgroundColor = .white
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        addSubview(tableView)
    }

    private func initConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
