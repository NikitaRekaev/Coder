import UIKit

final class TopTabsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants

    private enum Constants {
        
        static let borderHeight: CGFloat = 2
        
        enum Text {
            static let font = R.Fonts.interMedium(with: 15)
            static let selectedFont = R.Fonts.interSemiBold(with: 15)
        }
        
        enum Content {
            static let height: CGFloat = 36
            static let width: CGFloat = -16
            static let leading: CGFloat = 16
        }
    }
    
    // MARK: - Properties
    
    static let identifier = "Cell"
    
    private(set) var model: Department?
    
    // MARK: - Views
    
    private let bottomBorderView = UIView()
    private let label = UILabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBorderAppearance()
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        [label, bottomBorderView].forEach { contentView.addSubview($0) }
        [contentView, label, bottomBorderView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Constants.Content.height),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Content.leading),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: Constants.Content.width),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: Constants.borderHeight)
        ])
    }
}

// MARK: - Public Methods

extension TopTabsCollectionViewCell {
    
    func setCellSelected(_ isSelected: Bool) {
        if isSelected {
            bottomBorderView.isHidden = false
            label.textColor = R.Colors.Text.active
            label.font = Constants.Text.font
        } else {
            bottomBorderView.isHidden = true
            label.textColor = R.Colors.Text.inActive
            label.font = Constants.Text.selectedFont
        }
    }
    
    func setModel(_ department: Department) {
        self.model = department
        label.text = department.title
        label.textColor = R.Colors.Text.inActive
    }
}

// MARK: - Private Methods

private extension TopTabsCollectionViewCell {
    
    func setBorderAppearance() {
        bottomBorderView.backgroundColor = R.Colors.violet
        bottomBorderView.isHidden = false
    }
}
