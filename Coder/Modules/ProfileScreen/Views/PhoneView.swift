import UIKit

final class PhoneView: BaseView {
    
    let phoneButton = UIButton(type: .system)
    
    private let phoneView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
    private let phoneImageView = UIImageView()
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
    
    func setData(phoneNumber: String) {
        phoneButton.setTitle(phoneNumber, for: .normal)
    }
}

// MARK: - Private Methods

private extension PhoneView {
   
    func setupUI() {
        addSubview(phoneView)
        
        addSubview(phoneImageView)
        phoneImageView.image = UIImage(named: "phone")
        phoneImageView.layer.borderWidth = 0
        
        addSubview(phoneButton)
        phoneButton.setTitleColor(.black, for: .normal)
        phoneButton.setTitleColor(.gray, for: .highlighted)
        phoneButton.isHidden = false
        phoneButton.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    func setupConstraints() {
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneImageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor),
            phoneImageView.leadingAnchor.constraint(
                equalTo: phoneView.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneButton.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 14),
            phoneButton.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor)
        ])
    }
}
