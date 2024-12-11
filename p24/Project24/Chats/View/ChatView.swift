//
//  ChatView.swift
//  Project24
//
//  Created by Hrishikesh D S on 25/11/24.
//

import UIKit

class ChatView: UIView {

    // MARK: - UI Components
    let tableView = UITableView()
    let messageInputField = UITextField()
    let sendButton = UIButton(type: .system)
    let containerView = UIView()
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let loader = UIActivityIndicatorView(style: .large)

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .white
        setupTableView()
        setupBlurEffectView()
        setupLoader()
        setupContainerView()
        setupMessageInputField()
        setupSendButton()
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        addSubview(tableView)
    }

    private func setupMessageInputField() {
        messageInputField.layer.borderColor = UIColor.gray.cgColor
        messageInputField.layer.borderWidth = 1.0
        messageInputField.layer.cornerRadius = 10
        messageInputField.placeholder = "Ask me anything..."
        messageInputField.font = UIFont.systemFont(ofSize: 16)
        messageInputField.translatesAutoresizingMaskIntoConstraints = false
        messageInputField.autoresizingMask = .flexibleHeight
        messageInputField.textAlignment = .left
        containerView.addSubview(messageInputField)
    }

    private func setupSendButton() {
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
    }

    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }

    private func setupBlurEffectView() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurEffectView)
    }

    private func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        addSubview(loader)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.topAnchor),

            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60),

            messageInputField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            messageInputField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            messageInputField.heightAnchor.constraint(equalToConstant: 40),
            messageInputField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -80),

            sendButton.leadingAnchor.constraint(equalTo: messageInputField.trailingAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            loader.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),

            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public Methods
    func configureTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    func configureSendButton(target: Any, action: Selector) {
        sendButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func toggleLoader(show: Bool) {
        if show {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
    }
}
