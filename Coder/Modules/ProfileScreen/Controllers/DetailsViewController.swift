import UIKit

class DetailsViewCOntroller: BaseViewController<ProfileView> {
    var employee: EmployeeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondViewController"
    }
    override func viewDidAppear(_ animated: Bool) {
        let formattedPhone = formatPhone(phone: employee.phone)
        let formattedBirthday = formatDate(date: employee.birthdayDate)
        let calculatedYears = calculateYears(date: employee.birthdayDate)
        mainView.setData(firstName: employee.firstName,
                         lastName: employee.lastName,
                         tag: employee.userTag,
                         department: employee.department,
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
                let str = "\(years)"
            return str
            }
        }
        return "Не удалось вычислить год"
    }
}
