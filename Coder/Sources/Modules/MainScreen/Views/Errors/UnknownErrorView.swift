import UIKit

final class UnknownErrorView: BaseView {
    
    // MARK: - Views
    
    let tryAgainButton = UnknownErrorView.makeTryAgainButton()
    
    private let imageView = UnknownErrorView.makeImageView()
    private let titleLabel = UnknownErrorView.makeTitleLabel()
    private let subTitleLabel = UnknownErrorView.makeSubTitleLabel()
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        self.backgroundColor = .white
    }
    
    // MARK: - ConfigureUI
    
    override func configureUI() {
        [imageView, titleLabel, subTitleLabel, tryAgainButton].forEach { addSubview($0) }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.Image.centerYAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Title.top)
        ])
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.SubTitle.top)
        ])
        
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Constants.Button.top)
        ])
    }
}

// MARK: - Created SubViews

private extension UnknownErrorView {
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = R.Images.nlo
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    static func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.text = R.Strings.UnknownError.title.localizedString
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = R.Colors.Text.active
        
        return titleLabel
    }
    
    static func makeSubTitleLabel() -> UILabel {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = R.Strings.UnknownError.message.localizedString
        subTitleLabel.font = Constants.SubTitle.font
        subTitleLabel.textColor = R.Colors.Text.inActive
        
        return subTitleLabel
    }
    
    static func makeTryAgainButton() -> UIButton {
        let tryAgainButton = UIButton()
        
        tryAgainButton.backgroundColor = .clear
        tryAgainButton.titleLabel?.font = Constants.Button.font
        tryAgainButton.setTitleColor(R.Colors.violet, for: .normal)
        tryAgainButton.setTitle(R.Strings.UnknownError.tryAgainSelected.localizedString,
                                for: .highlighted)
        tryAgainButton.setTitle(R.Strings.UnknownError.tryAgain.localizedString,
                                for: .normal)
        
        return tryAgainButton
    }
}

// MARK: - Constants

private enum Constants {
    
    enum Image {
        static let centerYAnchor: CGFloat = -50
    }
    
    enum Title {
        static let font = R.Fonts.interSemiBold(with: 17)
        static let top: CGFloat = 8
    }
    
    enum SubTitle {
        static let font = R.Fonts.interRegular(with: 16)
        static let top: CGFloat = 12
    }
    
    enum Button {
        static let font = R.Fonts.interSemiBold(with: 17)
        static let top: CGFloat = 12
    }
}
