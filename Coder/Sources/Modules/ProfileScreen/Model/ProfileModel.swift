import UIKit

final class ProfileModel {
    
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
        
        if let date = date {
            var date = formatter.string(from: date)
            date.removeLast(.three)
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
}

// MARK: - Constants

private enum Constants {
    
    static let four = 4
    
    enum Phone {
        static let startIndex = 7
        static let offsetByTwelve = 12
        static let offsetByFifteen = 15
    }
}
