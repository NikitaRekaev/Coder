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

// MARK: - Localized Depertment

extension Department: CaseIterable {
    var title: String {
        switch self {
        case .all:
            return R.Strings.Department.all.localizedString
        case .design:
            return R.Strings.Department.design.localizedString
        case .analytics:
            return R.Strings.Department.analytics.localizedString
        case .management:
            return R.Strings.Department.management.localizedString
        case .ios:
            return R.Strings.Department.ios.localizedString
        case .android:
            return R.Strings.Department.android.localizedString
        case .qa:
            return R.Strings.Department.qa.localizedString
        case .frontend:
            return R.Strings.Department.frontend.localizedString
        case .backend:
            return R.Strings.Department.backend.localizedString
        case .hr:
            return R.Strings.Department.hr.localizedString
        case .pr:
            return R.Strings.Department.pr.localizedString
        case .backOffice:
            return R.Strings.Department.backOffice.localizedString
        case .support:
            return R.Strings.Department.support.localizedString
        }
    }
}
