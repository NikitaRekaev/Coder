import UIKit

final class InternalErrorView: BaseView {
    
    // MARK: - Views
    
    let tryAgainButton = InternalErrorView.makeTryAgainButton()
    
    private let imageView = InternalErrorView.makeImageView()
    private let titleLabel = InternalErrorView.makeTitleLabel()
    private let subTitleLabel = InternalErrorView.makeSubTitleLabel()
    
    // MARK: - Setting View
    
    override func setViewAppearance() {
        self.backgroundColor = .white
    }
    
    override func setViewPosition() {
        [imageView, titleLabel, subTitleLabel, tryAgainButton].forEach { addView($0) }
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.Image.centerYAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Title.top),
            
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.SubTitle.top),
            
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Constants.Button.top)
        ])
    }
}

// MARK: - Created SubViews

private extension InternalErrorView {
    
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
