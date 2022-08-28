import UIKit

class TopTabsCollectionViewCell: UICollectionViewCell {
    private(set) var model: DepartmentModel?
    static let identifier = "Cell"
    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Inter-Medium", size: 15)
        return view
    }()

    private var bottomBorderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 2))
    func setCellSelected(_ isSelected: Bool) {
        if isSelected {
            bottomBorderView.isHidden = false
            label.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        } else {
            bottomBorderView.isHidden = true
            label.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        }
    }
    func setModel(_ department: DepartmentModel) {
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
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.heightAnchor.constraint(equalToConstant: 36).isActive = true
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -16).isActive = true
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            bottomBorderView.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
            bottomBorderView.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            bottomBorderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
    }
