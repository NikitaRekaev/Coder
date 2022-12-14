import UIKit

final class SearchErrorView: BaseView {
    
    // MARK: - Constants

    private enum Constants {
        
        enum Image {
            static let top: CGFloat = 80
            static let proportions: CGFloat = 56
        }
        
        enum Title {
            static let font = R.Fonts.interSemiBold(with: 17)
            static let top: CGFloat = 8
        }
        
        enum SupTitle {
            static let font = R.Fonts.interRegular(with: 16)
            static let top: CGFloat = 12
        }
    }
    
    // MARK: - Views
    
    private let loupe = SearchErrorView.makeLoupeImageView()
    private let titleLabel = SearchErrorView.makeTitleLabel()
    private let subTitleLabel = SearchErrorView.makeSubTitleLabel()
    
    // MARK: - Setting View
    
    override func setViewAppearance() {
        self.backgroundColor = .white
    }
    
    override func setViewPosition() {
        [loupe, titleLabel, subTitleLabel].forEach { addView($0) }
        
        NSLayoutConstraint.activate([
            loupe.centerXAnchor.constraint(equalTo: centerXAnchor),
            loupe.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Image.top),
            loupe.widthAnchor.constraint(equalToConstant: Constants.Image.proportions),
            loupe.heightAnchor.constraint(equalToConstant: Constants.Image.proportions),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: loupe.bottomAnchor, constant: Constants.Title.top),
            
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: Constants.SupTitle.top)
        ])
    }
}

// MARK: - Created SubViews

private extension SearchErrorView {
    
    static func makeLoupeImageView() -> UIImageView {
        let loupe = UIImageView()
        loupe.image = R.Images.loupe
        return loupe
    }
    
    static func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.text = R.Strings.SearchError.title.localizedString
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = R.Colors.Text.active
        
        return titleLabel
    }
    
    static func makeSubTitleLabel() -> UILabel {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = R.Strings.SearchError.message.localizedString
        subTitleLabel.font = Constants.SupTitle.font
        subTitleLabel.textColor = R.Colors.Text.inActive
        
        return subTitleLabel
    }
}
