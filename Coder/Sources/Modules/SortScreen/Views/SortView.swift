import UIKit

final class SortView: BaseView {
    
    // MARK: - Properties
    
    var sortButtonArray: [SortButton] = []
    
    // MARK: - Views
    
    let buttonStack = SortView.makeButtonStack()
    
    private let topView = SortView.makeTopView()
    private let titleLabel = SortView.makeTitleLabel()
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        backgroundColor = .white
        
        SortModel.allCases.forEach({ model in
            let sortButton = SortButton(model: model, title: getModelName(model))
            buttonStack.addArrangedSubview(sortButton)
            sortButtonArray.append(sortButton)
        })
    }
    
    // MARK: - ConfigureUI
    
    override func configureUI() {
        [topView, titleLabel, buttonStack].forEach { addSubview($0) }
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            topView.widthAnchor.constraint(equalToConstant: Constants.TopView.width),
            topView.heightAnchor.constraint(equalToConstant: Constants.TopView.height),
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .zero)])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.TitleLable.top),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
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

// MARK: - Creating Subviews

private extension SortView {
    
    static func makeTopView() -> UIView {
        let topView = UIView()
        
        topView.backgroundColor = R.Colors.SearchBar.placeholder
        topView.layer.cornerRadius = Constants.TopView.cornerRadius
        
        return topView
    }
    
    static func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.text = R.Strings.Sort.title.localizedString
        titleLabel.font = Constants.TitleLable.font
        titleLabel.textColor = R.Colors.Text.active
        
        return titleLabel
    }
    
    static func makeButtonStack() -> UIStackView {
        let buttonStack = UIStackView()
        
        buttonStack.axis = .vertical
        buttonStack.spacing = Constants.ButtonStack.spacing
        buttonStack.alignment = .leading
        
        return buttonStack
    }
}

// MARK: - Private Methods

private extension SortView {
    
    func getModelName(_ model: SortModel) -> String {
        switch(model) {
        case .alphabet: return R.Strings.Sort.sortByAlphabet.localizedString
        case .birhDate: return R.Strings.Sort.sortByBirthday.localizedString
        }
    }
}

// MARK: - Constants

private enum Constants {
    
    enum TopView {
        static let cornerRadius: CGFloat = 2
        static let width: CGFloat = 56
        static let height: CGFloat = 4
    }
    
    enum TitleLable {
        static let font = R.Fonts.interSemiBold(with: 20)
        static let top: CGFloat = 24
    }
    
    enum ButtonStack {
        static let spacing: CGFloat = 35
        static let top: CGFloat = 41.5
        static let leading: CGFloat = 26
        static let trailing: CGFloat = 26
    }
}
