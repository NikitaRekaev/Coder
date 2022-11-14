import UIKit

final class SortButton: UIButton {
    
    // MARK: - Properties
    
    var model: SortModel!
    
    // MARK: - Initialization
    
    convenience init(model: SortModel, title: String) {
        self.init(frame: .zero)
        self.model = model
        
        setTitle(title, for: .normal)
        
        configureAppearance()
        configureUI()
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
    
    func configureAppearance() {
        self.setImage(R.Images.Sort.unChecked, for: .normal)
        self.setImage(R.Images.Sort.isChecked, for: .selected)
        self.setTitleColor(R.Colors.Text.active, for: .normal)
        self.titleLabel?.font = Constants.font
        self.titleEdgeInsets.left = Constants.insetsLeft
        self.contentHorizontalAlignment = .left
    }
    
    func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)])
    }
}

// MARK: - Constants

private enum Constants {
    static let font = R.Fonts.interMedium(with: 16)
    static let insetsLeft: CGFloat = 14
}
