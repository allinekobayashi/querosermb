import UIKit

final class ExchangeDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let volumesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let exchange: ExchangeViewModel
    
    init(exchange: ExchangeViewModel) {
        self.exchange = exchange
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureWithExchange()
    }
    
    private func setup() {
        view.addSubview(scrollView)
        view.backgroundColor = .systemBackground
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(websiteButton)
        contentView.addSubview(statusLabel)
        contentView.addSubview(volumesStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            websiteButton.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            websiteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            websiteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            volumesStackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            volumesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            volumesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            volumesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
    }
    
    private func configureWithExchange() {
        nameLabel.text = exchange.name
        idLabel.text = "ID: \(exchange.id)"
        statusLabel.text = "Status: \(exchange.status)"
        
        if !exchange.volumes.isEmpty {
            let volumesTitleLabel = UILabel()
            volumesTitleLabel.text = "Volumes:"
            volumesTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            volumesStackView.addArrangedSubview(volumesTitleLabel)
            
            for volume in exchange.volumes {
                let volumeLabel = UILabel()
                volumeLabel.font = .systemFont(ofSize: 16)
                volumeLabel.textColor = .secondaryLabel
                volumeLabel.text = volume
                volumesStackView.addArrangedSubview(volumeLabel)
            }
        }
        
        if let website = exchange.website {
            websiteButton.setTitle(website, for: .normal)
            websiteButton.isHidden = false
        } else {
            websiteButton.isHidden = true
        }
    }
    
    @objc private func websiteButtonTapped() {
        guard let website = exchange.website,
              let url = URL(string: website) else { return }
        UIApplication.shared.open(url)
    }
} 
