import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static let identifier = "tableCell"
    var shouldShowBirthday = false
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let departmentLabel = UILabel()
    let birthdayLabel = UILabel()
    
    private let tagLabel = UILabel()
    
    // MARK: SkeletonView
    
    private let imageSkeletonView = UIView()
    private let nameSkeletonView = UIView()
    private let departmentSkeletonView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        setupUI()
        setupSkeletonUI()
        setupConstraints()
        setSkeletonViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public method
    
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
    
    func setData(firstName: String, lastName: String, tag: String, department: Department?, dateBirth: String) {
        avatarImageView.image = UIImage(named: "goose")
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag
        departmentLabel.text = department?.title
        birthdayLabel.text = dateBirth
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        addSubview(avatarImageView)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 0
        
        addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.text = "Nikita Rekaev"
        nameLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        nameLabel.font = UIFont(name: "Inter-Medium", size: 16)
        
        addSubview(departmentLabel)
        departmentLabel.numberOfLines = 0
        departmentLabel.text = "iOS Developer"
        departmentLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        departmentLabel.font = UIFont(name: "Inter-Regular", size: 13)
        
        addSubview(tagLabel)
        tagLabel.numberOfLines = 0
        tagLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        tagLabel.font = UIFont(name: "Inter-Medium", size: 14)
        
        addSubview(birthdayLabel)
        birthdayLabel.numberOfLines = 0
        birthdayLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        birthdayLabel.font = UIFont(name: "Inter-Regular", size: 15)
        birthdayLabel.isHidden = true
    }
    
    private func setupSkeletonUI() {
        addSubview(imageSkeletonView)
        imageSkeletonView.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        imageSkeletonView.layer.cornerRadius = 36
        imageSkeletonView.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        
        addSubview(nameSkeletonView)
        nameSkeletonView.frame = CGRect(x: 0, y: 0, width: 144, height: 16)
        nameSkeletonView.layer.cornerRadius = 8
        nameSkeletonView.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        
        addSubview(departmentSkeletonView)
        departmentSkeletonView.frame = CGRect(x: 0, y: 0, width: 80, height: 12)
        departmentSkeletonView.layer.cornerRadius = 6
        departmentSkeletonView.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
    }
    
    private func setupConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 72),
            avatarImageView.widthAnchor.constraint(equalToConstant: 72)
        ])
        
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -20)
       ])
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 20)
        ])
        
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdayLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -12),
            birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19.5)
        ])
    }
    
    private func setSkeletonViewsConstraints() {
        imageSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSkeletonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageSkeletonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageSkeletonView.heightAnchor.constraint(equalToConstant: 72),
            imageSkeletonView.widthAnchor.constraint(equalToConstant: 72)
        ])
        
        nameSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameSkeletonView.leadingAnchor.constraint(equalTo: imageSkeletonView.trailingAnchor, constant: 16),
            nameSkeletonView.centerYAnchor.constraint(equalTo: imageSkeletonView.centerYAnchor, constant: -20),
            nameSkeletonView.widthAnchor.constraint(equalToConstant: 144),
            nameSkeletonView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        departmentSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentSkeletonView.leadingAnchor.constraint(equalTo: nameSkeletonView.leadingAnchor),
            departmentSkeletonView.centerYAnchor.constraint(equalTo: nameSkeletonView.centerYAnchor, constant: 20),
            departmentSkeletonView.widthAnchor.constraint(equalToConstant: 80),
            departmentSkeletonView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
