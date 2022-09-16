import UIKit

final class SortView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        
        enum TitleLable {
            static let text = "Сортировка"
            static let font = R.Fonts.interSemiBold(with: 20)
            static let topAnchor: CGFloat = 21.5
        }
        
        enum BackButton {
            static let topAnchor: CGFloat = 22.75
            static let leadingAnchor: CGFloat = 33.5
        }
        
        enum SortButton {
            static let font = R.Fonts.interMedium(with: 16)
            static let insetsLeft: CGFloat = 14
        }
        
        enum AlphabetSortButton {
            static let sortString = "По алфавиту"
            static let topAnchor: CGFloat = 41.5
            static let leadingAnchor: CGFloat = 26
            static let widthAnchor: CGFloat = 140
        }
        
        enum BirthdaySortButton {
            static let sortString = "По дню рождения"
            static let topAnchor: CGFloat = 35
            static let widthAnchor: CGFloat = 180
        }
    }
    
    // MARK: - Views
    
    lazy var backButton = UIButton()
    lazy var alphabetSortButton = UIButton()
    lazy var birthdaySortButton = UIButton()
    
    private lazy var titleLabel = UILabel()
    
    // MARK: - Initilization
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: - Private Methods

private extension SortView {
    
    func setupUI() {
        backgroundColor = .white
        
        titleLabel.text = Constants.TitleLable.text
        titleLabel.font = Constants.TitleLable.font
        titleLabel.textColor = Constants.textColor
        
        backButton.setImage(R.Images.backArrow, for: .normal)
        
        alphabetSortButton.setTitle(Constants.AlphabetSortButton.sortString, for: .normal)
        alphabetSortButton.setImage(R.Images.Sort.unChecked, for: .normal)
        alphabetSortButton.setImage(R.Images.Sort.isChecked, for: .selected)
        alphabetSortButton.setTitleColor(Constants.textColor, for: .normal)
        alphabetSortButton.titleLabel?.font = Constants.SortButton.font
        alphabetSortButton.titleEdgeInsets.left = Constants.SortButton.insetsLeft
        
        birthdaySortButton.setTitle(Constants.BirthdaySortButton.sortString, for: .normal)
        birthdaySortButton.setImage(R.Images.Sort.unChecked, for: .normal)
        birthdaySortButton.setImage(R.Images.Sort.isChecked, for: .selected)
        birthdaySortButton.setTitleColor(Constants.textColor, for: .normal)
        birthdaySortButton.titleLabel?.font = Constants.SortButton.font
        birthdaySortButton.titleEdgeInsets.left = Constants.SortButton.insetsLeft
    }
    
    func setupConstraints() {
        [titleLabel, backButton, alphabetSortButton, birthdaySortButton].forEach { addSubview($0) }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.TitleLable.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.BackButton.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.BackButton.leadingAnchor)
        ])
        
        alphabetSortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alphabetSortButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                    constant: Constants.AlphabetSortButton.topAnchor),
            alphabetSortButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: Constants.AlphabetSortButton.leadingAnchor),
            alphabetSortButton.widthAnchor.constraint(equalToConstant: Constants.AlphabetSortButton.widthAnchor)
        ])
        
        birthdaySortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdaySortButton.topAnchor.constraint(equalTo: alphabetSortButton.bottomAnchor,
                                                    constant: Constants.BirthdaySortButton.topAnchor),
            birthdaySortButton.leadingAnchor.constraint(equalTo: alphabetSortButton.leadingAnchor),
            birthdaySortButton.widthAnchor.constraint(equalToConstant: Constants.BirthdaySortButton.widthAnchor)
        ])
    }
}
