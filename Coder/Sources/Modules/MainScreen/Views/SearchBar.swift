import UIKit

final class SearchBar: UISearchBar {
    
    // MARK: - Properties
    
    private lazy var cancelBarButtonAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Inter-SemiBold", size: 15) ?? .boldSystemFont(ofSize: 15),
        .foregroundColor: #colorLiteral(red: 0.3960784314, green: 0.2039215686, blue: 1, alpha: 1)
    ]
    
    private lazy var placeholderAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Inter-Medium", size: 15) ?? .systemFont(ofSize: 15),
        .foregroundColor: UIColor(red: 195/255, green: 195/255, blue: 198/255, alpha: 1)
    ]
    
    private lazy var placeholderAttributedString: NSAttributedString = .init(
        string: "Введи имя, тег, почту...",
        attributes: placeholderAttributes
    )
    
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
        
        setImage(UIImage(named: "list-ui-alt"), for: .bookmark, state: .normal)
        setImage(UIImage(named: "list-ui-alt_selected"), for: .bookmark, state: .selected)
        setImage(UIImage(named: "x-clear"), for: .clear, state: .normal)
        
        setValue("Отмена", forKey: "cancelButtonText")
        
        setPositionAdjustment(UIOffset(horizontal: 10, vertical: .zero), for: .search)
        setPositionAdjustment(UIOffset(horizontal: -10, vertical: .zero), for: .bookmark)
        setPositionAdjustment(UIOffset(horizontal: -10, vertical: .zero), for: .clear)
        searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: .zero)
        
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = 16
        searchTextField.leftView = UIImageView(image: UIImage(named: "Vector"))
        searchTextField.font = UIFont(name: "Inter-Regular", size: 15)
        searchTextField.attributedPlaceholder = placeholderAttributedString
        searchTextField.tintColor = #colorLiteral(red: 0.3960784314, green: 0.2039215686, blue: 1, alpha: 1)
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(cancelBarButtonAttributes, for: .normal)
        
        let textFieldInsideSearchBar = value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
    }
}
