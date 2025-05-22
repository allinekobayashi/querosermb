import UIKit

class ErrorView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemOrange
        imageView.image = UIImage(systemName: "exclamationmark.triangle")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Failed to load exchanges"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Create button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.clockwise")
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24)
        configuration.background.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        configuration.cornerStyle = .medium
        
        // Set title and font
        configuration.attributedTitle = AttributedString("Retry")
        configuration.attributedTitle?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        button.configuration = configuration
        return button
    }()
    
    private var onRetry: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(retryButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -32),
            
            errorImageView.widthAnchor.constraint(equalToConstant: 60),
            errorImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    func configure(error: String, onRetry: @escaping () -> Void) {
        messageLabel.text = error
        self.onRetry = onRetry
    }
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
} 
