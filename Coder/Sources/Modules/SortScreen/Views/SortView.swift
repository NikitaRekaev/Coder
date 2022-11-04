import UIKit

final class SortView: BaseView {
    
    // MARK: - Views
    
    let backButton = UIButton()
    let buttonStack = UIStackView()
    
    var sortButtonArray: [SortButton] = []
    
    private let titleLabel = UILabel()
    
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
        
        SortModel.allCases.forEach({ model in
            let sortButton = SortButton(model: model, title: getModelName(model))
            buttonStack.addArrangedSubview(sortButton)
            sortButtonArray.append(sortButton)
        })
    }
    
    func getModelName(_ model: SortModel) -> String {
        switch(model) {
        case .alphabet: return "по алфавиту"
        case .birhDate: return "по дню рождения"
        }
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
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                             constant: Constants.ButtonStack.top),
            buttonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                 constant: Constants.ButtonStack.leading),
            buttonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                  constant: Constants.ButtonStack.trailing)
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
    
    enum ButtonStack {
        static let top: CGFloat = 41.5
        static let leading: CGFloat = 26
        static let trailing: CGFloat = 26
    }
}
