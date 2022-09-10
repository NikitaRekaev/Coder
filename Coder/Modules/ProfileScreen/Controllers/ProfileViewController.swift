import UIKit

class ProfileViewController: BaseViewController<ProfileView> {
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondViewController"
        mainView.phoneView.phoneButton.addTarget(self, action: #selector(phoneButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
        
        let formattedPhone = formatPhone(phone: item.phone)
        let formattedBirthday = formatDate(date: item.birthdayDate)
        let calculatedYears = calculateYears(date: item.birthdayDate)
        mainView.setData(firstName: item.firstName,
                         lastName: item.lastName,
                         tag: item.userTag,
                         department: item.department,
                         phone: formattedPhone,
                         dateBirth: formattedBirthday,
                         years: calculatedYears)
    }
    
    func formatPhone(phone: String) -> String {
        var formattedPhone = "+7 (" + phone.filter { $0.isNumber }
        formattedPhone.insert(contentsOf: [")", " "], at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 7))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 12))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 15))
        return formattedPhone
    }
    
    func formatDate (date: Date?) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        if let date = date {
            var date = formatter.string(from: date)
            date.removeLast(3)
            return date
        }
        return "Дата не была получена"
    }
    
    func calculateYears(date: Date?) -> String {
        if let date = date {
            let calendar = Calendar.current
            let dateCurrent = Date()
            
            if let years = calendar.dateComponents([.year], from: date, to: dateCurrent).year {
                var stringOfAge = "\(years)"
                let arrayOfAge = stringOfAge.compactMap { $0.wholeNumberValue }
                
                if arrayOfAge.last != nil {
                    switch arrayOfAge.last! {
                    case 1: stringOfAge = "\(years) год"
                    case 2...4: stringOfAge = "\(years) года"
                    default: stringOfAge = "\(years) лет"
                    }
                }
                return stringOfAge
            }
        }
        return "Не удалось вычислить год"
    }
    
    private func aler(title: String, titleSecond: String) {
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
    
    @objc func phoneButtonClicked() {
        aler(title: formatPhone(phone: item.phone), titleSecond: formatPhone(phone: item.phone))
    }
}
