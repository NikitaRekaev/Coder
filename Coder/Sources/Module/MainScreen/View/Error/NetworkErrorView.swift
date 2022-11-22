import UIKit

final class NetworkErrorView: BaseView {
    
    // MARK: - Constants

    private enum Constants {
        
        static let textFont = R.Fonts.interMedium(with: 13)
        static let frameX: CGFloat = 24
        static let width: CGFloat = 327
        static let height: CGFloat = 50
    }
    
    // MARK: - Views
    
    private let messageErrorLabel = NetworkErrorView.makeMessageErrorLabel()
    
    // MARK: - Setting View
    
    override func setViewAppearance() {
        backgroundColor = R.Colors.networkError
    }
    
    override func setViewPosition() {
        self.addSubview(messageErrorLabel)
        
        messageErrorLabel.frame = CGRect(x: Constants.frameX,
                                         y: frame.midY - 10,
                                         width: Constants.width,
                                         height: Constants.height)
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
