import UIKit

class PhoneView: BaseView {
    private let phoneView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
        return view
    }()
    private let phoneImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "phone")
        view.layer.borderWidth = 0
        return view
    }()
    let phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.isHidden = false
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        return button
     }()
    override func setup() {
        addSubview(phoneView)
        addSubview(phoneImageView)
        addSubview(phoneButton)
        setPhoneImageConstraints()
        setPhoneButtonConstraints()
    }
   private func setPhoneImageConstraints() {
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor).isActive = true
        phoneImageView.leadingAnchor.constraint(equalTo: phoneView.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 20).isActive = true
    }
    private func setPhoneButtonConstraints() {
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 14).isActive = true
        phoneButton.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor).isActive = true
    }

    func setData(phoneNumber: String) {
        phoneButton.setTitle(phoneNumber, for: .normal)
    }
}
