import Foundation

struct MainModel {
    
    // MARK: - Constants

    private enum Constants {
        
        static let year = 365
        static let week = 7
        static let moreWeek = 8
    }
    
    // MARK: - Properties
    
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
                $0.department == selectedDepartment ||
                selectedDepartment == nil ||
                selectedDepartment == departmentAll
            })
            .filter({
                $0.firstName.starts(with: searchText) ||
                $0.lastName.starts(with: searchText) ||
                $0.userTag.starts(with: searchText) ||
                searchText.isEmpty
            })
    }
}

// MARK: - Sort By Date Birh

extension MainModel {
    
    var thisYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) > .zero
        }
    }
    
    var nextYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) < .zero
        }
    }
    
    var userModelForSections: [[Item]] {
        return [thisYearBirthdayUser, nextYearBirthdayUser]
    }
    
    func formatDate (date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("dd MMM")
        
        guard let date = date else { return "" }
        
        var dateFormatter = formatter.string(from: date)
        
        switch dateFormatter.count {
        case Constants.week:
            dateFormatter.removeLast()
        case Constants.moreWeek:
            dateFormatter.removeLast(.two)
        default:
            return dateFormatter
        }
        
        return dateFormatter
    }
    
    func calculateDayDifference(birthdayDate: Date?) -> Int {
        guard let date = birthdayDate else {
            return .zero
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
            return .zero
        }
        
        guard let dayDifference = calendar.dateComponents([.day],
                                                          from: dateCurrent,
                                                          to: bufferDate).day else {
            return .zero
        }
        
        return dayDifference
    }
    
    mutating func userSortByDate() {
        var users = users
        users.sort { date1, date2 in
            guard let date1 = date1.birthdayDate else { return false }
            guard let date2 = date2.birthdayDate else { return false }
            var dayDifference1 = calculateDayDifference(birthdayDate: date1)
            var dayDifference2 = calculateDayDifference(birthdayDate: date2)
            
            if dayDifference1 < .zero {
                dayDifference1 += Constants.year
            }
            if dayDifference2 < .zero {
                dayDifference2 += Constants.year
            }
            
            return dayDifference1 < dayDifference2
        }
    }
}
