import UIKit

final class ProfileView: BaseView {
    
    // MARK: - Views
    
    let phoneView = PhoneView()
    let avatarImageView = ProfileView.makeAvatarImageView()
    
    private let upView = ProfileView.makeUpView()
    private let nameLabel = ProfileView.makeNameLable()
    private let tagLabel = ProfileView.makeTagLable()
    private let departmentLabel = ProfileView.makeDepartmentLabel()
    private let stackView = ProfileView.makeStackView()
    private let birthView = BirthView()
    
    // MARK: - Appearance
    
    override func setup() {
        backgroundColor = .white
        setConstraints()
    }
}

// MARK: - SetData

extension ProfileView {
    
    func setImage(urlString: String) {
        avatarImageView.loadImage(from: urlString)
    }
    
    func setData(firstName: String,
                 lastName: String,
                 tag: String,
                 department: Department?,
                 phone: String,
                 dateBirth: String,
                 years: String) {
        avatarImageView.image = R.Images.stopper
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag.lowercased()
        departmentLabel.text = department?.title
        phoneView.setData(phoneNumber: phone)
        birthView.setData(dateBirth: dateBirth, years: years)
    }
}

// MARK: - Created SubViews

private extension ProfileView {
    
    static func makeUpView() -> UIView {
        let upView = UIView()
        upView.backgroundColor = R.Colors.profileBackground
        return upView
    }
    
    static func makeAvatarImageView() -> UIImageView {
        let avatarImageView = UIImageView()
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Constants.Avatar.cornerRadius
        
        return avatarImageView
    }
    
    static func makeNameLable() -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.font = Constants.Name.font
        nameLabel.textColor = R.Colors.Text.active
        
        return nameLabel
    }
    
    static func makeTagLable() -> UILabel {
        let tagLabel = UILabel()
        
        tagLabel.font = Constants.Tag.font
        tagLabel.textColor = R.Colors.Text.inActive
        
        return tagLabel
    }
    
    static func makeDepartmentLabel() -> UILabel {
        let departmentLabel = UILabel()
        
        departmentLabel.font = Constants.Department.font
        departmentLabel.textColor = R.Colors.Text.secondary
        
        return departmentLabel
    }
    
    static func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        
        return stackView
    }
}

// MARK: - Private Methods

private extension ProfileView {
    
    func setConstraints() {
        [upView, avatarImageView, nameLabel, tagLabel, departmentLabel, stackView].forEach { addSubview($0) }
        
        upView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upView.topAnchor.constraint(equalTo: topAnchor),
            upView.centerXAnchor.constraint(equalTo: centerXAnchor),
            upView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.upViewBottom),
            upView.leadingAnchor.constraint(equalTo: leadingAnchor),
            upView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: upView.topAnchor, constant: Constants.Avatar.top),
            avatarImageView.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Avatar.proportions),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Avatar.proportions)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.Name.top)
        ])
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Constants.Tag.leading),
            tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
            departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.Department.top)
        ])
        
        [birthView, phoneView].forEach { stackView.addArrangedSubview($0) }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: upView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Contstants

private enum Constants {
    
    static let stackViewSpacing: CGFloat = 73.5
    static let upViewBottom: CGFloat = 104
    
    enum Avatar {
        static let cornerRadius = CGFloat(104 / 2)
        static let top: CGFloat = 72
        static let proportions: CGFloat = 104
    }
    
    enum Name {
        static let font = R.Fonts.interBold(with: 24)
        static let top: CGFloat = 24
    }
    
    enum Tag {
        static let font = R.Fonts.interRegular(with: 17)
        static let leading: CGFloat = 4
    }
    
    enum Department {
        static let font = R.Fonts.interRegular(with: 13)
        static let top: CGFloat = 12
    }
    
}
