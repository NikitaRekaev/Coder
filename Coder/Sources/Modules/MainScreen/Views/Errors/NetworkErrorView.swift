import UIKit

final class NetworkErrorView: BaseView {
    
    // MARK: - Views
    
    private let messageErrorLabel = NetworkErrorView.makeMessageErrorLabel()
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = R.Colors.networkError
    }
    
    // MARK: - UI
    
    override func configureUI() {
        super.configureUI()
        addSubview(messageErrorLabel)
        
        messageErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageErrorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.leftOrRight),
            messageErrorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.leftOrRight),
            messageErrorLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.bottom)
        ])
    }
}

// MARK: - Creating Subviews

private extension NetworkErrorView {
    
    static func makeMessageErrorLabel() -> UILabel {
        let label = UILabel()
        label.text = R.Strings.NetworkError.networkErrorText.localizedString
        label.font = Constants.textFont
        label.textColor = .white
        label.numberOfLines = .zero
        
        return label
    }
}

// MARK: - Constants

private enum Constants {
    static let textFont = R.Fonts.interMedium(with: 13)
    static let leftOrRight: CGFloat = 24
    static let bottom: CGFloat = 12
}
