import UIKit

final class TopTabsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    private(set) var model: Department?
    
    private let bottomBorderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 2))
    private let label = UILabel()
    
    func setCellSelected(_ isSelected: Bool) {
        if isSelected {
            bottomBorderView.isHidden = false
            label.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
            label.font = UIFont(name: "Inter-Medium", size: 15)
        } else {
            bottomBorderView.isHidden = true
            label.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
            label.font = UIFont(name: "Inter-SamiBold", size: 15)
        }
    }
    
    func setModel(_ department: Department) {
        self.model = department
        label.text = department.title
        label.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .black
        
        bottomBorderView.backgroundColor = #colorLiteral(red: 0.4257887602, green: 0.1908605397, blue: 1, alpha: 1)
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
            bottomBorderView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 36),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -16)
        ])
    }
}
