import UIKit

final class PhoneView: BaseView {
    
    // MARK: - Views
    
    let phoneButton = PhoneView.makePhoneButton()
    
    private let phoneImageView = PhoneView.makePhoneImageView()
    private let phoneView = UIView(frame: CGRect(x: .zero, y: .zero,
                                                 width: Constants.View.width,
                                                 height: Constants.View.height))
    
    // MARK: - ConfigureUI
    
    override func configureUI() {
        [phoneView, phoneImageView, phoneButton].forEach { addSubview($0) }
        
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneImageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor),
            phoneImageView.leadingAnchor.constraint(
                equalTo: phoneView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.Image.leading)
        ])
        
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneButton.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor,
                                                 constant: Constants.Button.trailig),
            phoneButton.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor)
        ])
    }
}

// MARK: - Set Data Methods

extension PhoneView {
    func setData(phoneNumber: String) {
        phoneButton.setTitle(phoneNumber, for: .normal)
    }
}

// MARK: - Created SubViews

private extension PhoneView {
    
    static func makePhoneImageView() -> UIImageView {
        let phoneImageView = UIImageView()
        phoneImageView.image = R.Images.Profile.phone
        return phoneImageView
    }
    
    static func makePhoneButton() -> UIButton {
        let phoneButton = UIButton(type: .system)
        
        phoneButton.setTitleColor(R.Colors.Text.active, for: .normal)
        phoneButton.setTitleColor(R.Colors.Text.inActive, for: .highlighted)
        phoneButton.isHidden = false
        phoneButton.titleLabel?.font = Constants.Button.font
        
        return phoneButton
    }
}

// MARK: - Constants

private enum Constants {
    
    enum View {
        static let width: CGFloat = UIScreen.main.bounds.width
        static let height: CGFloat = 73.5
    }
    
    enum Image {
        static let leading: CGFloat = 20
    }
    
    enum Button {
        static let font = R.Fonts.interMedium(with: 16)
        static let trailig: CGFloat = 14
    }
}
