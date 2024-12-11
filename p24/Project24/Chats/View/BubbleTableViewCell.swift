//
//  BubbleTableViewCell.swift
//  Project24
//
//  Created by Hrishikesh D S on 25/11/24.
//

import UIKit

class BubbleTableViewCell: UITableViewCell {

    private let bubbleView = UIView()
    private let messageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBubbleView()
        setupMessageLabel()
    }

    func setupBubbleView() {
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.layer.cornerRadius = 10
        bubbleView.layer.masksToBounds = true
        contentView.addSubview(bubbleView)
    }

    func setupMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        bubbleView.addSubview(messageLabel)
    }

    func configure(with message: (role: String, content: String), cellWidth: CGFloat) {
        messageLabel.text = message.content

        if message.role == "user" {
            // User's message bubble - Right-aligned
            bubbleView.backgroundColor = UIColor.lightGray
            messageLabel.textColor = UIColor.black
            messageLabel.textAlignment = .right

            NSLayoutConstraint.deactivate(bubbleView.constraints)
            NSLayoutConstraint.activate([
                bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 15),
                bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
                bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

                messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
                messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
                messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 10),
                messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10)
            ])
        } else {
            // API's message bubble - Left-aligned
            bubbleView.backgroundColor = UIColor.systemGreen
            messageLabel.textColor = UIColor.white
            messageLabel.textAlignment = .left

            NSLayoutConstraint.deactivate(bubbleView.constraints)
            NSLayoutConstraint.activate([
                bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),
                bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
                bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

                messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
                messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
                messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 10),
                messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10)
            ])
        }
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
