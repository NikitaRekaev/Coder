import Foundation

enum Department: String, Codable {
    case all
    case design
    case analytics
    case management
    case ios
    case android
    case qa
    case frontend
    case backend
    case hr
    case pr
    case backOffice = "back_office"
    case support
}

extension Department: CaseIterable {
    var title: String {
        switch self {
        case .all:
            return "Все"
        case .design:
            return "Designers"
        case .analytics:
            return "Analysts"
        case .management:
            return "Managers"
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .qa:
            return "QA"
        case .frontend:
            return "Frontend"
        case .backend:
            return "Backend"
        case .hr:
            return "HR"
        case .pr:
            return "PR"
        case .backOffice:
            return "Back Office"
        case .support:
            return "Support"
        }
    }
}
