import UIKit

final class SortView: BaseView {
    
    // MARK: - Views
    
    lazy var backButton = UIButton()
    lazy var alphabetSortButton = SortButton()
    lazy var birthdaySortButton = SortButton()
    lazy var buttonStack = UIStackView()
    
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
        
        buttonStack.axis = .vertical
        buttonStack.spacing = 35
        buttonStack.alignment = .leading
        
        alphabetSortButton.setTitle(Constants.AlphabetSortButton.text, for: .normal)
        birthdaySortButton.setTitle(Constants.BirthdaySortButton.text, for: .normal)
    }
    
    func setupConstraints() {
        [titleLabel, backButton, buttonStack].forEach { addSubview($0) }
        
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
        
        [alphabetSortButton, birthdaySortButton].forEach { buttonStack.addArrangedSubview($0) }
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                             constant: Constants.AlphabetSortButton.top),
            buttonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                 constant: Constants.AlphabetSortButton.leading),
            buttonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: Constants.AlphabetSortButton.trailing)
        ])
        
//                alphabetSortButton.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
        //            alphabetSortButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
        //                                                    constant: Constants.AlphabetSortButton.top),
        //            alphabetSortButton.leadingAnchor.constraint(equalTo: leadingAnchor,
        //                                                        constant: Constants.AlphabetSortButton.leading),
        //            alphabetSortButton.widthAnchor.constraint(equalToConstant: Constants.AlphabetSortButton.width)
        //        ])
        //
        //        birthdaySortButton.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            birthdaySortButton.topAnchor.constraint(equalTo: alphabetSortButton.bottomAnchor,
        //                                                    constant: Constants.BirthdaySortButton.top),
        //            birthdaySortButton.leadingAnchor.constraint(equalTo: alphabetSortButton.leadingAnchor),
        //            birthdaySortButton.widthAnchor.constraint(equalToConstant: Constants.BirthdaySortButton.width)
        //        ])
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
    
    enum AlphabetSortButton {
        static let text = "По алфавиту"
        static let top: CGFloat = 41.5
        static let leading: CGFloat = 26
        static let trailing: CGFloat = 26
        static let width: CGFloat = 140
    }
    
    enum BirthdaySortButton {
        static let text = "По дню рождения"
        static let top: CGFloat = 35
        static let width: CGFloat = 180
    }
}
