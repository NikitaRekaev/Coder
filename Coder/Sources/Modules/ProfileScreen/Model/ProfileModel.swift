import UIKit

struct ProfileModel {
    
    func formatPhone(phone: String) -> String {
        
        var formattedPhone = "+7 (" + phone.filter { $0.isNumber }
        formattedPhone.insert(contentsOf: [")", " "],
                              at: formattedPhone.index(formattedPhone.startIndex,
                                                       offsetBy: Constants.Phone.startIndex))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex,
                                                            offsetBy: Constants.Phone.offsetByTwelve))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex,
                                                            offsetBy: Constants.Phone.offsetByFifteen))
        
        return formattedPhone
    }
    
    func formatDate (date: Date?) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        guard let date = date else { return "" }
        
        var dateFormatter = formatter.string(from: date)
        dateFormatter.removeLast(.three)
        return dateFormatter
        
    }
    
    func calculateYears(date: Date?) -> String {
        
        guard let date = date else { return "" }
        
        let calendar = Calendar.current
        let dateCurrent = Date()
        
        guard let years = calendar.dateComponents([.year], from: date, to: dateCurrent).year else {
            return ""
        }
        
        if (Constants.eleven...Constants.fourteen).contains(years) {
            return "\(years) \(R.Strings.Years.thirdCase.localizedString)"
        }
        
        let age = years % .ten
        var stringOfAge = "\(years)"
        
        switch age {
        case .one:
            stringOfAge = "\(years) \(R.Strings.Years.firstCase.localizedString)"
        case .two...Constants.four:
            stringOfAge = "\(years) \(R.Strings.Years.secondCase.localizedString)"
        default:
            stringOfAge = "\(years) \(R.Strings.Years.thirdCase.localizedString)"
        }
        
        return stringOfAge
    }
}

// MARK: - Constants

private enum Constants {
    
    static let four = 4
    static let eleven = 11
    static let fourteen = 14
    
    enum Phone {
        static let startIndex = 7
        static let offsetByTwelve = 12
        static let offsetByFifteen = 15
    }
}
