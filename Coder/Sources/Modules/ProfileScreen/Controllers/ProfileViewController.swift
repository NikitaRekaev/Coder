import UIKit

final class ProfileViewController: BaseViewController<ProfileView> {
    
    var item: Item!
    
    private let model = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        setTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setData()
    }
}

// MARK: Private Methods

private extension ProfileViewController {
    
    func setBackButton() {
        navigationItem.leftBarButtonItem = BackBarButtonItem(target: navigationController ?? UINavigationController())
    }
    
    func setTargets() {
        mainView.phoneView.phoneButton.addTarget(self, action: #selector(phoneButtonClicked), for: .touchUpInside)
    }
    
    func setData() {
        mainView.setImage(urlString: item.avatarUrl)
        let formattedPhone = model.formatPhone(phone: item.phone)
        let formattedBirthday = model.formatDate(date: item.birthdayDate)
        let calculatedYears = model.calculateYears(date: item.birthdayDate)
        mainView.setData(firstName: item.firstName,
                         lastName: item.lastName,
                         tag: item.userTag,
                         department: item.department,
                         phone: formattedPhone,
                         dateBirth: formattedBirthday,
                         years: calculatedYears)
    }
    
    func aler(title: String, titleSecond: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let number = UIAlertAction(title: title, style: .default) { _ in
            if let phoneCallURL = URL(string: "tel://\(titleSecond)") {
                let application: UIApplication = UIApplication.shared
                if application.canOpenURL(phoneCallURL) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.black, forKey: "titleTextColor")
        number.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(number)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Action

@objc
private extension ProfileViewController {
    func phoneButtonClicked() {
        aler(title: model.formatPhone(phone: item.phone), titleSecond: item.phone)
    }
}
