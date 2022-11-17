import Foundation

// MARK: - Properties

struct Item: Codable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department
    let position: String
    let birthday: String
    let phone: String
}

// MARK: - Format Date

extension Item {
    var birthdayDate: Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: birthday)
    }
}
