import UIKit

final class TopTabsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "Cell"
    
    private enum Constants {
        static let textFont = R.Fonts.interMedium(with: 15)
        static let textSelectedFont = R.Fonts.interSemiBold(with: 15)
        static let borderHeight: CGFloat = 2
        static let contentHeight: CGFloat = 36
        static let contentWidth: CGFloat = -16
        static let contentLeading: CGFloat = 16
    }
    
    // MARK: - Properties
    
    private(set) var model: Department?
    
    // MARK: - Views
    
    private let bottomBorderView = UIView()
    private let label = UILabel()
    
    func setCellSelected(_ isSelected: Bool) {
        if isSelected {
            bottomBorderView.isHidden = false
            label.textColor = R.Colors.Text.active
            label.font = Constants.textFont
        } else {
            bottomBorderView.isHidden = true
            label.textColor = R.Colors.Text.inActive
            label.font = Constants.textSelectedFont
        }
    }
    
    func setModel(_ department: Department) {
        self.model = department
        label.text = department.title
        label.textColor = R.Colors.Text.inActive
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .black
        
        bottomBorderView.backgroundColor = R.Colors.violet
        bottomBorderView.isHidden = false
        
        contentView.addSubview(label)
        contentView.addSubview(bottomBorderView)
        
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: Constants.borderHeight)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Constants.contentHeight),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.contentLeading),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: Constants.contentWidth)
        ])
    }
}
