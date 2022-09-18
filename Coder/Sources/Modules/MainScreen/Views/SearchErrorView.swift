import UIKit

final class SearchErrorView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        enum Image {
            static let top: CGFloat = 80
            static let proportions: CGFloat = 56
        }
        
        enum Title {
            static let text = "Мы никого не нашли"
            static let font = R.Fonts.interSemiBold(with: 17)
            static let top: CGFloat = 8
        }
        
        enum SupTitle {
            static let text = "Попробуйте скорректировать запрос"
            static let font = R.Fonts.interRegular(with: 16)
            static let top: CGFloat = 12
        }
    }
    
    // MARK: - Views
    
    private lazy var loupe = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    
    // MARK: - Setup
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: - Private Methods

private extension SearchErrorView {
    
    func setupUI() {
        loupe.image = R.Images.loupe
        
        titleLabel.text = Constants.Title.text
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = R.Colors.Text.active
        
        subTitleLabel.text = Constants.SupTitle.text
        subTitleLabel.font = Constants.SupTitle.font
        subTitleLabel.textColor = R.Colors.Text.inActive
    }
    
    func setupConstraints() {
        [loupe, titleLabel, subTitleLabel].forEach { addSubview($0) }
        
        loupe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loupe.centerXAnchor.constraint(equalTo: centerXAnchor),
            loupe.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Image.top),
            loupe.widthAnchor.constraint(equalToConstant: Constants.Image.proportions),
            loupe.heightAnchor.constraint(equalToConstant: Constants.Image.proportions)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: loupe.bottomAnchor, constant: Constants.Title.top)
        ])
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant: Constants.SupTitle.top)
        ])
    }
}
