import UIKit

class ExchangeTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let volumesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(volumesStackView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            volumesStackView.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            volumesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            volumesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            volumesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with exchange: ExchangeViewModel) {
        nameLabel.text = exchange.name
        idLabel.text = "ID: \(exchange.id)"
        
        // Clear existing volume labels
        volumesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add volume labels
        for volume in exchange.volumes {
            let volumeLabel = UILabel()
            volumeLabel.font = .systemFont(ofSize: 14)
            volumeLabel.textColor = .secondaryLabel
            volumeLabel.text = volume
            volumesStackView.addArrangedSubview(volumeLabel)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        idLabel.text = nil
        volumesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
} 
