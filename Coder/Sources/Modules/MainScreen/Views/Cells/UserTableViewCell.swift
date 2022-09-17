import UIKit

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "tableCell"
    
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
            static let centerYAnchor: CGFloat = -12
            static let width: CGFloat = 144
            static let height: CGFloat = 16
            static let cornerRadius: CGFloat = 8
            static let frame = CGRect(x: 0, y: 0, width: 144, height: 16)
        }
        
        enum Department {
            static let font = R.Fonts.interRegular(with: 13)
            static let centerYAnchor: CGFloat = 20
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
            static let centerYAnchor: CGFloat = -12
            static let trailing: CGFloat = -19.5
        }
    }
    
    // MARK: - Views
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let departmentLabel = UILabel()
    let birthdayLabel = UILabel()
    
    private let tagLabel = UILabel()
    
    // MARK: SkeletonView
    
    private let imageSkeletonView = UIView()
    private let nameSkeletonView = UIView()
    private let departmentSkeletonView = UIView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        
        setupSkeletonUI()
        setupSkeletonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetViews

extension UserTableViewCell {
    
    func setBirthdayLabelVisibility(shouldShowBirthday: Bool) {
        birthdayLabel.isHidden = !shouldShowBirthday
    }
    
    func setSkeletonView() {
        nameLabel.isHidden = true
        avatarImageView.isHidden = true
        departmentLabel.isHidden = true
        tagLabel.isHidden = true
        departmentLabel.isHidden = true
        
        imageSkeletonView.isHidden = false
        nameSkeletonView.isHidden = false
        departmentSkeletonView.isHidden = false
    }
    
    func setViewWithData() {
        nameLabel.isHidden = false
        avatarImageView.isHidden = false
        departmentLabel.isHidden = false
        tagLabel.isHidden = false
        departmentLabel.isHidden = false
        
        imageSkeletonView.isHidden = true
        nameSkeletonView.isHidden = true
        departmentSkeletonView.isHidden = true
    }
}

// MARK: - SetData

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

// MARK: - Setup Views

private extension UserTableViewCell {
    
    func setupUI() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Constants.Image.cornerRadius
        
        nameLabel.textColor = R.Colors.Text.active
        nameLabel.font = Constants.Name.font

        departmentLabel.textColor = R.Colors.Text.secondary
        departmentLabel.font = Constants.Department.font
        
        tagLabel.textColor = R.Colors.Text.inActive
        tagLabel.font = Constants.Tag.font
        
        birthdayLabel.textColor = R.Colors.Text.secondary
        birthdayLabel.font = Constants.Birthday.font
        birthdayLabel.isHidden = true
    }
    
    func setupConstraints() {
        [avatarImageView, nameLabel, tagLabel, departmentLabel, birthdayLabel].forEach { addSubview($0) }
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Image.leading),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Image.proportions),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Image.proportions)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                               constant: Constants.Name.leading),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,
                                               constant: Constants.Name.centerYAnchor)
        ])
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Constants.Tag.leading),
            tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor,
                                                     constant: Constants.Department.centerYAnchor)
        ])
        
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdayLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,
                                                   constant: Constants.Birthday.centerYAnchor),
            birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: Constants.Birthday.trailing)
        ])
    }
}

// MARK: - Setup Skeleton

private extension UserTableViewCell {
    
    func setupSkeletonUI() {
        imageSkeletonView.frame = Constants.Image.frame
        imageSkeletonView.layer.cornerRadius = Constants.Image.cornerRadius
        imageSkeletonView.backgroundColor = R.Colors.skeleton
        
        nameSkeletonView.frame = Constants.Name.frame
        nameSkeletonView.layer.cornerRadius = Constants.Name.cornerRadius
        nameSkeletonView.backgroundColor = R.Colors.skeleton
        
        departmentSkeletonView.frame = Constants.Department.frame
        departmentSkeletonView.layer.cornerRadius = Constants.Department.cornerRadius
        departmentSkeletonView.backgroundColor = R.Colors.skeleton
    }
    
    func setupSkeletonConstraints() {
        [imageSkeletonView, nameSkeletonView, departmentSkeletonView].forEach { addSubview($0) }
        
        imageSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSkeletonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageSkeletonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Image.leading),
            imageSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Image.proportions),
            imageSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Image.proportions)
        ])
        
        nameSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameSkeletonView.leadingAnchor.constraint(equalTo: imageSkeletonView.trailingAnchor,
                                                      constant: Constants.Name.leading),
            nameSkeletonView.centerYAnchor.constraint(equalTo: imageSkeletonView.centerYAnchor,
                                                      constant: Constants.Name.centerYAnchor),
            nameSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Name.width),
            nameSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Name.height)
        ])
        
        departmentSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentSkeletonView.leadingAnchor.constraint(equalTo: nameSkeletonView.leadingAnchor),
            departmentSkeletonView.centerYAnchor.constraint(equalTo: nameSkeletonView.centerYAnchor,
                                                            constant: Constants.Department.centerYAnchor),
            departmentSkeletonView.widthAnchor.constraint(equalToConstant: Constants.Department.width),
            departmentSkeletonView.heightAnchor.constraint(equalToConstant: Constants.Department.height)
        ])
    }
}
