import UIKit

class ProfileView: BaseView {
    let birthView = BirthView()
    let phoneView = PhoneView()
    private let upView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height/2.7))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
    private let employeeImageView: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "goose")
            view.layer.shadowColor = CGColor(red: 22/255, green: 30/255, blue: 52/255, alpha: 0.08)
            view.layer.shadowOffset = CGSize(width: 0, height: 8)
            view.layer.shadowRadius = 12
            view.layer.shadowOpacity = 1
            return view
        }()
     let nameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Inter-Bold", size: 24)
        view.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        return view
    }()
     let tagLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Inter-Regular", size: 14)
        view.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        return view
    }()
     let departmentLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Inter-Regular", size: 13)
        view.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        return view
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 73.5
        return view
    }()

        override func setup() {
        employeeImageView.image = employeeImageView.image?.resized(CGSize(width: 104, height: 104))
        employeeImageView.contentMode = .scaleAspectFill
        backgroundColor = .white
        stackView.addArrangedSubview(birthView)
        stackView.addArrangedSubview(phoneView)
        addSubview(stackView)
        addSubview(upView)
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        employeeImageView.topAnchor.constraint(equalTo: upView.topAnchor, constant: 104).isActive = true
        employeeImageView.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 24).isActive = true
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        stackView.topAnchor.constraint(equalTo: upView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
// swiftlint:disable function_parameter_count
    func setData(firstName: String,
                 lastName: String,
                 tag: String,
                 department: DepartmentModel?,
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
