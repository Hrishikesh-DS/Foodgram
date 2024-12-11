import UIKit

class RecipeDetailsView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let recipeImageView = UIImageView()
    let recipeTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let chatGPTButton = UIButton(type: .system)
    let chatGPTLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupScrollView()
        setupContentView()
        setupRecipeImageView()
        setupRecipeTitleLabel()
        setupDescriptionLabel()
        setupLikeButton()
        setupLikeCountLabel()
        setupChatGPTButton()
        setupChatGPTLabel()
        setupConstraints()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }

    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }

    private func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.layer.borderWidth = 1
        recipeImageView.layer.borderColor = UIColor.lightGray.cgColor
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipeImageView)
    }

    private func setupRecipeTitleLabel() {
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        recipeTitleLabel.textAlignment = .center
        recipeTitleLabel.numberOfLines = 2
        recipeTitleLabel.textColor = .darkText
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipeTitleLabel)
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
    }

    private func setupLikeButton() {
        likeButton.setTitle("Like", for: .normal)
        likeButton.tintColor = .systemBlue
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeButton)
    }

    private func setupLikeCountLabel() {
        likeCountLabel.text = "0 Likes"
        likeCountLabel.font = UIFont.systemFont(ofSize: 14)
        likeCountLabel.textColor = .darkGray
        likeCountLabel.textAlignment = .center
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeCountLabel)
    }

    private func setupChatGPTButton() {
        chatGPTButton.setImage(UIImage(systemName: "message.circle"), for: .normal)
        chatGPTButton.tintColor = .systemGreen
        chatGPTButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatGPTButton)
    }

    private func setupChatGPTLabel() {
        chatGPTLabel.text = "ChatBot"
        chatGPTLabel.font = UIFont.systemFont(ofSize: 14)
        chatGPTLabel.textColor = .systemGreen
        chatGPTLabel.textAlignment = .center
        chatGPTLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatGPTLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Recipe Image
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImageView.heightAnchor.constraint(equalToConstant: 220),

            // Recipe Title
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            // ChatGPT Button
            chatGPTButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25),
            chatGPTButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),

            // ChatGPT Label
            chatGPTLabel.topAnchor.constraint(equalTo: chatGPTButton.bottomAnchor, constant: 2),
            chatGPTLabel.centerXAnchor.constraint(equalTo: chatGPTButton.centerXAnchor),
            chatGPTLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            likeButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -15),
            likeButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: -60),

            likeCountLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 4),
            likeCountLabel.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
