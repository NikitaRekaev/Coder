import UIKit

final class ProfileView: BaseView {
    
    let phoneView = PhoneView()
    let avatarImageView = UIImageView()
    
    private let nameLabel = UILabel()
    private let tagLabel = UILabel()
    private let departmentLabel = UILabel()
    private let upView = UIView()
    private let stackView = UIStackView()
    private let birthView = BirthView()
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
    
    func setImage(urlString: String) {
        avatarImageView.loadImage(from: urlString)
    }
    
    // swiftlint:disable function_parameter_count
    func setData(firstName: String,
                 lastName: String,
                 tag: String,
                 department: Department?,
                 phone: String,
                 dateBirth: String,
                 years: String) {
        avatarImageView.image = UIImage(named: "goose")
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag.lowercased()
        departmentLabel.text = department?.title
        phoneView.setData(phoneNumber: phone)
        birthView.setData(dateBirth: dateBirth, years: years)
    }
    // swiftlint:enable function_parameter_count
}

// MARK: - Private Methods

private extension ProfileView {
    
    func setupUI() {
        backgroundColor = .white
        
        upView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = CGFloat(104 / 2)
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Inter-Bold", size: 24)
        nameLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        
        tagLabel.numberOfLines = 0
        tagLabel.font = UIFont(name: "Inter-Regular", size: 14)
        tagLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        
        departmentLabel.numberOfLines = 0
        departmentLabel.font = UIFont(name: "Inter-Regular", size: 13)
        departmentLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 73.5
        stackView.addArrangedSubview(birthView)
        stackView.addArrangedSubview(phoneView)
    }
    
    func setupConstraints() {
        [upView, avatarImageView, nameLabel, tagLabel, departmentLabel, stackView].forEach { addSubview($0) }
        
        upView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upView.topAnchor.constraint(equalTo: topAnchor),
            upView.centerXAnchor.constraint(equalTo: centerXAnchor),
            upView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 104),
            upView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            upView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: upView.topAnchor, constant: 72),
            avatarImageView.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 104),
            avatarImageView.widthAnchor.constraint(equalToConstant: 104)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24)
        ])
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: upView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
