import Foundation

final class MainModel {
    
    //MARK: - Variable
    
    var searchText = ""
    var users: [Item] = []
    var selectedDepartment: Department?
    
    private let departmentAll = Department.all
    
}

// MARK: - Search and Tabs

extension MainModel {
    var filteredUser: [Item] {
        return users
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil || selectedDepartment == departmentAll
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty
            })
    }
}

// MARK: - Sort By Date Birh

extension MainModel {
    
    var thisYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) > 0
        }
    }
    
    var nextYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) < 0
        }
    }
    
    var userModelForSections: [[Item]] {
        return [thisYearBirthdayUser, nextYearBirthdayUser]
    }
    
    func formatDate (date: Date?) -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.setLocalizedDateFormatFromTemplate("dd MMM")

        if let date = date {
            var date = formatter.string(from: date)
            if date.count == 7 {
                date.removeLast()
            }
            if date.count == 8 {
                date.removeLast(2)
            }
            return date
        }
        return "Дата не была получена"
    }
    
    func calculateDayDifference(birthdayDate: Date?) -> Int {
        guard let date = birthdayDate else {
            return 0
        }
        
        let calendar = Calendar.current
        let dateCurrent = Date()
        let dateComponentsNow = calendar.dateComponents([.day, .month, .year], from: dateCurrent)
        let birthdayDateComponents = calendar.dateComponents([.day, .month], from: date)
        
        var bufferDateComponents = DateComponents()
        bufferDateComponents.year = dateComponentsNow.year
        bufferDateComponents.month = birthdayDateComponents.month
        bufferDateComponents.day = birthdayDateComponents.day
        
        guard let bufferDate = calendar.date(from: bufferDateComponents) else {
            return 0
        }
        
        guard let dayDifference = calendar.dateComponents([.day],
                                                          from: dateCurrent, to: bufferDate).day else {
            return 0
        }
        
        return dayDifference
    }
    
    func userSortByDate() {
        users.sort { date1, date2 in
            guard let date1 = date1.birthdayDate else { return false }
            guard let date2 = date2.birthdayDate else { return false }
            var dayDifference1 = calculateDayDifference(birthdayDate: date1)
            var dayDifference2 = calculateDayDifference(birthdayDate: date2)
            
            if dayDifference1 < 0 {
                dayDifference1 += 365
            }
            if dayDifference2 < 0 {
                dayDifference2 += 365
            }
            
            return dayDifference1 < dayDifference2
        }
    }
}
