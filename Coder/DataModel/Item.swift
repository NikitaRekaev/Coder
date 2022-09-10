import Foundation

struct Item: Codable {
    
    let id: String
    let avatarURL: String?
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department?
    let position: String
    let birthday: String
    let phone: String
}

extension Item {
    var birthdayDate: Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: birthday)
    }
}
