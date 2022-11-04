import UIKit

final class SortView: BaseView {
    
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
        titleLabel.textColor = R.Colors.Text.active
        
        backButton.setImage(R.Images.backArrow, for: .normal)
        
        alphabetSortButton.setTitle(Constants.AlphabetSortButton.text, for: .normal)
        alphabetSortButton.setImage(R.Images.Sort.unChecked, for: .normal)
        alphabetSortButton.setImage(R.Images.Sort.isChecked, for: .selected)
        alphabetSortButton.setTitleColor(R.Colors.Text.active, for: .normal)
        alphabetSortButton.titleLabel?.font = Constants.SortButton.font
        alphabetSortButton.titleEdgeInsets.left = Constants.SortButton.insetsLeft
        
        birthdaySortButton.setTitle(Constants.BirthdaySortButton.text, for: .normal)
        birthdaySortButton.setImage(R.Images.Sort.unChecked, for: .normal)
        birthdaySortButton.setImage(R.Images.Sort.isChecked, for: .selected)
        birthdaySortButton.setTitleColor(R.Colors.Text.active, for: .normal)
        birthdaySortButton.titleLabel?.font = Constants.SortButton.font
        birthdaySortButton.titleEdgeInsets.left = Constants.SortButton.insetsLeft
    }
    
    func setupConstraints() {
        [titleLabel, backButton, alphabetSortButton, birthdaySortButton].forEach { addSubview($0) }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.TitleLable.top),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.BackButton.top),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.BackButton.leading)
        ])
        
        alphabetSortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alphabetSortButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                    constant: Constants.AlphabetSortButton.top),
            alphabetSortButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: Constants.AlphabetSortButton.leading),
            alphabetSortButton.widthAnchor.constraint(equalToConstant: Constants.AlphabetSortButton.width)
        ])
        
        birthdaySortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdaySortButton.topAnchor.constraint(equalTo: alphabetSortButton.bottomAnchor,
                                                    constant: Constants.BirthdaySortButton.top),
            birthdaySortButton.leadingAnchor.constraint(equalTo: alphabetSortButton.leadingAnchor),
            birthdaySortButton.widthAnchor.constraint(equalToConstant: Constants.BirthdaySortButton.width)
        ])
    }
}

// MARK: - Constants

private enum Constants {
    enum TitleLable {
        static let text = "Сортировка"
        static let font = R.Fonts.interSemiBold(with: 20)
        static let top: CGFloat = 21.5
    }
    
    enum BackButton {
        static let top: CGFloat = 22.75
        static let leading: CGFloat = 33.5
    }
    
    enum SortButton {
        static let font = R.Fonts.interMedium(with: 16)
        static let insetsLeft: CGFloat = 14
    }
    
    enum AlphabetSortButton {
        static let text = "По алфавиту"
        static let top: CGFloat = 41.5
        static let leading: CGFloat = 26
        static let width: CGFloat = 140
    }
    
    enum BirthdaySortButton {
        static let text = "По дню рождения"
        static let top: CGFloat = 35
        static let width: CGFloat = 180
    }
}
