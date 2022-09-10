import UIKit

class ProfileModel {
    
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
}
