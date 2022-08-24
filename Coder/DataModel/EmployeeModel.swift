import Foundation

struct EmployeeModel: Codable {
    let id: String
    let avatarURL: String?
    let firstName: String
    let lastName: String
    let userTag: String
    let department: [String]
    let position: String
    let birthday: String
    var birthdayDate: Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterGet.date(from: birthday)
        return date
}
    let phone: String
}

struct EmployeeList: Codable {
    let items: [EmployeeModel]
}
