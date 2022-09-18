import UIKit

final class SearchBar: UISearchBar {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let adjustingTextOffset: UIOffset = .init(horizontal: 10, vertical: .zero)
        static let adjustingRightIconOffset: UIOffset = .init(horizontal: -10, vertical: .zero)
        static let leftView = UIImageView(image: R.Images.SearchBar.leftImageNormal)
        
        enum TextFild {
            static let font = R.Fonts.interRegular(with: 15)
            static let key = "searchField"
            static let color = R.Colors.SearchBar.secondary
        }
        
        enum CancelButton {
            static let title = "Отмена"
            static let key = "cancelButtonText"
            static let attributes: [NSAttributedString.Key: Any] = [
                .font: R.Fonts.interSemiBold(with: 15),
                .foregroundColor: R.Colors.violet
            ]
        }
        
        enum Placeholder {
            static let attributes: [NSAttributedString.Key: Any] = [
                .font: R.Fonts.interMedium(with: 15),
                .foregroundColor: R.Colors.SearchBar.placeholder
            ]
            static let attributedString: NSAttributedString = .init(
                string: "Введи имя, тег, почту...",
                attributes: attributes
            )
        }
    }
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension SearchBar {
    
    func setupUI() {
        showsBookmarkButton = true
        
        setImage(R.Images.SearchBar.rightImageNormal, for: .bookmark, state: .normal)
        setImage(R.Images.SearchBar.rightImageSelected, for: .bookmark, state: .selected)
        setImage(R.Images.SearchBar.clear, for: .clear, state: .normal)
        
        setValue(Constants.CancelButton.title, forKey: Constants.CancelButton.key)
        
        setPositionAdjustment(Constants.adjustingTextOffset, for: .search)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .bookmark)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .clear)
        searchTextPositionAdjustment = Constants.adjustingTextOffset
        
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = Constants.cornerRadius
        searchTextField.leftView = Constants.leftView
        searchTextField.font = Constants.TextFild.font
        searchTextField.attributedPlaceholder = Constants.Placeholder.attributedString
        searchTextField.tintColor = R.Colors.violet
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(Constants.CancelButton.attributes, for: .normal)
        
        let textFieldInsideSearchBar = value(forKey: Constants.TextFild.key) as? UITextField
        textFieldInsideSearchBar?.backgroundColor = Constants.TextFild.color
    }
}
