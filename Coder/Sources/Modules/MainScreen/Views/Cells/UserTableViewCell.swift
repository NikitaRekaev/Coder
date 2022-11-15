import UIKit

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "tableCell"
    
    // MARK: - Views
    
    let avatarImageView = UserTableViewCell.makeAvatarImageView()
    let nameLabel = UserTableViewCell.makeNameLable()
    let departmentLabel = UserTableViewCell.makeDepartmentLabel()
    let birthdayLabel = UserTableViewCell.makeBirthdayLabel()
    
    private let tagLabel = UserTableViewCell.makeTagLabel()
    
    // MARK: SkeletonView
    
    private let avatarSkeletonView = UserTableViewCell.makeAvatarSkeletonView()
    private let nameSkeletonView = UserTableViewCell.makeNameSkeletonView()
    private let departmentSkeletonView = UserTableViewCell.makeDepartmentSkeletonView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        configureUI()
        configureSkeletonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set Views

extension UserTableViewCell {
    
    func setBirthdayLabelVisibility(shouldShowBirthday: Bool) {
        birthdayLabel.isHidden = !shouldShowBirthday
    }
    
    func setSkeletonView(show: Bool) {
        avatarSkeletonView.isHidden = !show
        nameSkeletonView.isHidden = !show
        departmentSkeletonView.isHidden = !show
    }
}

// MARK: - Set Data

extension UserTableViewCell {
    
    func setImage(urlString: String) {
        avatarImageView.loadImage(from: urlString)
    }
    
    func setData(firstName: String, lastName: String, tag: String, department: Department?, dateBirth: String) {
        avatarImageView.image = R.Images.stopper
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag
        departmentLabel.text = department?.title
        birthdayLabel.text = dateBirth
    }
}

// MARK: - Created SubViews

private extension UserTableViewCell {
    
    static func makeAvatarImageView() -> UIImageView {
        let avatarImageView = UIImageView()
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Constants.Image.cornerRadius
        
        return avatarImageView
    }
    
    static func makeNameLable() -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.textColor = R.Colors.Text.active
        nameLabel.font = Constants.Name.font
        
        return nameLabel
    }
    
    static func makeDepartmentLabel() -> UILabel {
        let departmentLabel = UILabel()
        
        departmentLabel.textColor = R.Colors.Text.secondary
        departmentLabel.font = Constants.Department.font
        
        return departmentLabel
    }
    
    static func makeTagLabel() -> UILabel {
        let tagLabel = UILabel()
        
        tagLabel.textColor = R.Colors.Text.inActive
        tagLabel.font = Constants.Tag.font
        
        return tagLabel
    }
    
    static func makeBirthdayLabel() -> UILabel {
        let birthdayLabel = UILabel()
        
        birthdayLabel.textColor = R.Colors.Text.secondary
        birthdayLabel.font = Constants.Birthday.font
        birthdayLabel.isHidden = true
        
        return birthdayLabel
    }
}

// MARK: - Configure Views

private extension UserTableViewCell {
    
    func configureUI() {
        [avatarImageView, nameLabel, tagLabel, departmentLabel, birthdayLabel].forEach { addView($0) }
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Image.leading),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Image.proportions),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Image.proportions),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                               constant: Constants.Name.leading),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,
                                               constant: Constants.Name.centerY),
            
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Constants.Tag.leading),
            tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor,
                                                     constant: Constants.Department.centerY),
            
            birthdayLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,
                                                   constant: Constants.Birthday.centerY),
            birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: Constants.Birthday.trailing)
        ])
    }
}

// MARK: - Created Skeleton SubViews

private extension UserTableViewCell {
    
    static func makeAvatarSkeletonView() -> UIView {
        let avatarSkeletonView = UIImageView()
        
        avatarSkeletonView.frame = Constants.Image.frame
        avatarSkeletonView.layer.cornerRadius = Constants.Image.cornerRadius
        avatarSkeletonView.backgroundColor = R.Colors.skeleton
        
        return avatarSkeletonView
    }
    
    static func makeNameSkeletonView() -> UIView {
        let nameSkeletonView = UIView()
        
        nameSkeletonView.frame = Constants.Name.frame
        nameSkeletonView.layer.cornerRadius = Constants.Name.cornerRadius
        nameSkeletonView.backgroundColor = R.Colors.skeleton
        
        return nameSkeletonView
    }
    
    static func makeDepartmentSkeletonView() -> UIView {
        let departmentSkeletonView = UIView()
        
        departmentSkeletonView.frame = Constants.Department.frame
        departmentSkeletonView.layer.cornerRadius = Constants.Department.cornerRadius
        departmentSkeletonView.backgroundColor = R.Colors.skeleton
        
        return departmentSkeletonView
    }
}

// MARK: - Configure Skeleton

private extension UserTableViewCell {
    
    func configureSkeletonUI() {
        [avatarSkeletonView, nameSkeletonView, departmentSkeletonView].forEach { addView($0) }
        
        NSLayoutConstraint.activate([
            avatarSkeletonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarSkeletonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Image.leading),
            avatarSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Image.proportions),
            avatarSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Image.proportions),
            
            nameSkeletonView.leadingAnchor.constraint(equalTo: avatarSkeletonView.trailingAnchor,
                                                      constant: Constants.Name.leading),
            nameSkeletonView.centerYAnchor.constraint(equalTo: avatarSkeletonView.centerYAnchor,
                                                      constant: Constants.Name.centerY),
            nameSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Name.width),
            nameSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Name.height),
            
            departmentSkeletonView.leadingAnchor.constraint(equalTo: nameSkeletonView.leadingAnchor),
            departmentSkeletonView.centerYAnchor.constraint(equalTo: nameSkeletonView.centerYAnchor,
                                                            constant: Constants.Department.centerY),
            departmentSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Department.width),
            departmentSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Department.height)
        ])
    }
}

// MARK: - Constants

private enum Constants {
    
    enum Image {
        static let leading: CGFloat = 10
        static let proportions: CGFloat = 72
        static let cornerRadius = CGFloat(72 / 2)
        static let frame = CGRect(x: 0, y: 0, width: 72, height: 72)
    }
    
    enum Name {
        static let font = R.Fonts.interMedium(with: 16)
        static let leading: CGFloat = 16
        static let centerY: CGFloat = -12
        static let width: CGFloat = 144
        static let height: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let frame = CGRect(x: 0, y: 0, width: 144, height: 16)
    }
    
    enum Department {
        static let font = R.Fonts.interRegular(with: 13)
        static let centerY: CGFloat = 20
        static let width: CGFloat = 80
        static let height: CGFloat = 12
        static let cornerRadius: CGFloat = 6
        static let frame = CGRect(x: 0, y: 0, width: 80, height: 12)
    }
    
    enum Tag {
        static let font = R.Fonts.interMedium(with: 14)
        static let leading: CGFloat = 4
    }
    
    enum Birthday {
        static let font = R.Fonts.interRegular(with: 15)
        static let centerY: CGFloat = -12
        static let trailing: CGFloat = -19.5
    }
}
