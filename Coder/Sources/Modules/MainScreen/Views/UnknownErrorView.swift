import UIKit

final class UnknownErrorView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Image {
            static let centerYAnchor: CGFloat = -50
        }
        
        enum Title {
            static let text = "Какой-то сверхразум всё сломал"
            static let font = R.Fonts.interSemiBold(with: 17)
            static let top: CGFloat = 8
        }
        
        enum SubTitle {
            static let text = "Постараемся быстро починить"
            static let font = R.Fonts.interRegular(with: 16)
            static let top: CGFloat = 12
        }
        
        enum Button {
            static let isNormaltext = "Попробовать снова"
            static let isSelectedText = "Меня нажали"
            static let font = R.Fonts.interSemiBold(with: 17)
            static let top: CGFloat = 12
        }
    }
    
    // MARK: - Views
    
    let tryAgainButton = UIButton()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // MARK: - Setup
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: Private methods

private extension UnknownErrorView {
    
    func setupUI() {
        imageView.image = R.Images.nlo
        imageView.clipsToBounds = true
        
        titleLabel.text = Constants.Title.text
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = R.Colors.Text.active
        
        subTitleLabel.text = Constants.SubTitle.text
        subTitleLabel.font = Constants.SubTitle.font
        subTitleLabel.textColor = R.Colors.Text.inActive
        
        tryAgainButton.backgroundColor = .clear
        tryAgainButton.setTitle(Constants.Button.isNormaltext, for: .normal)
        tryAgainButton.setTitleColor(R.Colors.violet, for: .normal)
        tryAgainButton.setTitle(Constants.Button.isSelectedText, for: .highlighted)
        tryAgainButton.titleLabel?.font = Constants.Button.font
    }
    
    func setupConstraints() {
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
