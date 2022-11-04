import UIKit

class SortButton: UIButton {
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
        setupUI()
        setupConstraint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension SortButton {
    func setupUI() {
        self.setImage(R.Images.Sort.unChecked, for: .normal)
        self.setImage(R.Images.Sort.isChecked, for: .selected)
        self.setTitleColor(R.Colors.Text.active, for: .normal)
        self.titleLabel?.font = Constants.font
        self.titleEdgeInsets.left = Constants.insetsLeft
        self.contentHorizontalAlignment = .left
    }
    
    func setupConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)])
    }
}

// MARK: - Constants

private enum Constants {
    static let font = R.Fonts.interMedium(with: 16)
    static let insetsLeft: CGFloat = 14
}
