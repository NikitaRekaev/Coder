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
    
    // swiftlint:disable function_parameter_count
    func setData(firstName: String,
                 lastName: String,
                 tag: String,
                 department: Department?,
                 phone: String,
                 dateBirth: String,
                 years: String) {
        
        self.nameLabel.text = "\(firstName) \(lastName)"
        self.tagLabel.text = tag
        self.departmentLabel.text = department?.title
        phoneView.setData(phoneNumber: phone)
        birthView.setData(dateBirth: dateBirth, years: years)
    }
    // swiftlint:enable function_parameter_count
}

// MARK: - Private Methods

private extension ProfileView {
    
    func setupUI() {
        backgroundColor = .white
        
        addSubview(upView)
        upView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        
        addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: "goose")
        avatarImageView.layer.shadowColor = CGColor(red: 22/255, green: 30/255, blue: 52/255, alpha: 0.08)
        avatarImageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        avatarImageView.layer.shadowRadius = 12
        avatarImageView.layer.shadowOpacity = 1
        
        addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Inter-Bold", size: 24)
        nameLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        
        addSubview(tagLabel)
        tagLabel.numberOfLines = 0
        tagLabel.font = UIFont(name: "Inter-Regular", size: 14)
        tagLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        
        addSubview(departmentLabel)
        departmentLabel.numberOfLines = 0
        departmentLabel.font = UIFont(name: "Inter-Regular", size: 13)
        departmentLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 73.5
        stackView.addArrangedSubview(birthView)
        stackView.addArrangedSubview(phoneView)
    }
    
    func setupConstraints() {
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
