import UIKit

class ProfileView: BaseView {
    
    let birthView = BirthView()
    let phoneView = PhoneView()
    
    private let upView: UIView = {
        let view = UIView()
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
        
        addSubview(upView)
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(birthView)
        stackView.addArrangedSubview(phoneView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        upView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upView.topAnchor.constraint(equalTo: topAnchor),
            upView.centerXAnchor.constraint(equalTo: centerXAnchor),
            upView.bottomAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 104),
            upView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            upView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)])
        
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        employeeImageView.topAnchor.constraint(equalTo: upView.topAnchor, constant: 72),
        employeeImageView.centerXAnchor.constraint(equalTo: upView.centerXAnchor)])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        nameLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
        nameLabel.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 24)])
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
        tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)])
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        departmentLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor),
        departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12)])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: upView.bottomAnchor),
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor)])
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
