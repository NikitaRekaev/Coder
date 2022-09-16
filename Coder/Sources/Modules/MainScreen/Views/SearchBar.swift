import UIKit

final class SearchBar: UISearchBar {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let activeTextFont = UIFont(name: "Inter-Regular", size: 15)
        static let tintColor = #colorLiteral(red: 0.3960784314, green: 0.2039215686, blue: 1, alpha: 1)
        static let adjustingTextOffset: UIOffset = .init(horizontal: 10, vertical: .zero)
        static let adjustingRightIconOffset: UIOffset = .init(horizontal: -10, vertical: .zero)
        static let clearImage = UIImage(named: "x-clear")
        static let sortImage = UIImage(named: "list-ui-alt")
        static let sortImageSelected = UIImage(named: "list-ui-alt_selected")
        static let leftView = UIImageView(image: UIImage(named: "Vector"))
        static let textFildKey = "searchField"
        static let textFildColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        static let cancelTitle = "Отмена"
        static let cancelKey = "cancelButtonText"
        static let cancelBarButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-SemiBold", size: 15) ?? .boldSystemFont(ofSize: 15),
            .foregroundColor: tintColor
        ]
        static let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Medium", size: 15) ?? .systemFont(ofSize: 15),
            .foregroundColor: UIColor(red: 195/255, green: 195/255, blue: 198/255, alpha: 1)
        ]
        static let placeholderAttributedString: NSAttributedString = .init(
            string: "Введи имя, тег, почту...",
            attributes: placeholderAttributes
        )
    }
    
    // MARK: - Initilization
    
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
        
        setImage(Constants.sortImage, for: .bookmark, state: .normal)
        setImage(Constants.sortImageSelected, for: .bookmark, state: .selected)
        setImage(Constants.clearImage, for: .clear, state: .normal)
        
        setValue(Constants.cancelTitle, forKey: Constants.cancelKey)
        
        setPositionAdjustment(Constants.adjustingTextOffset, for: .search)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .bookmark)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .clear)
        searchTextPositionAdjustment = Constants.adjustingTextOffset
        
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = Constants.cornerRadius
        searchTextField.leftView = Constants.leftView
        searchTextField.font = Constants.activeTextFont
        searchTextField.attributedPlaceholder = Constants.placeholderAttributedString
        searchTextField.tintColor = Constants.tintColor
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(Constants.cancelBarButtonAttributes, for: .normal)
        
        let textFieldInsideSearchBar = value(forKey: Constants.textFildKey) as? UITextField
        textFieldInsideSearchBar?.backgroundColor = Constants.textFildColor
    }
}
