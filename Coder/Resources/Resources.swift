import UIKit

typealias R = Resources

enum Resources {
    
    enum Images {
        static let stopper = UIImage(named: "goose")
        static let backArrow = UIImage(named: "back-arrow")
        static let nlo = UIImage(named: "NLO")
        static let loupe = UIImage(named: "loupe")
        
        enum Profile {
            static let start = UIImage(named: "star")
            static let phone = UIImage(named: "phone")
        }
        
        enum SearchBar {
            static let clear = UIImage(named: "x-clear")
            static let leftImageNormal = UIImage(named: "Vector")
            static let leftImageSelected = UIImage(named: "vector_editing")
            static let rightImageNormal = UIImage(named: "list-ui-alt")
            static let rightImageSelected = UIImage(named: "list-ui-alt_selected")
        }
        
        enum Sort {
            static let unChecked = UIImage(named: "UnChecked")
            static let isChecked = UIImage(named: "isChecked")
        }
    }
    
    enum Colors {
        static let violet = UIColor(hex: "#6534FF") ?? .systemGreen
        static let separator = UIColor(hex: "#C3C3C6") ?? .systemGreen
        static let profileBackground = UIColor(hex: "#F7F7F8") ?? .systemGreen
        static let skeleton = UIColor(hex: "#F3F3F6") ?? .systemGreen
        
        enum SearchBar {
            static let secondary = UIColor(hex: "#F7F7F8") ?? .systemGreen
            static let placeholder = UIColor(hex: "#C3C3C6") ?? .systemGreen
        }
        
        enum Text {
            static let active = UIColor(hex: "#050510") ?? .systemGreen
            static let inActive = UIColor(hex: "#97979B") ?? .systemGreen
            static let secondary = UIColor(hex: "#55555C") ?? .systemGreen
        }
    }
    
    enum Fonts {
        static func interMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Medium", size: size) ?? UIFont()
        }
        
        static func interRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Regular", size: size) ?? UIFont()
        }
        
        static func interSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-SemiBold", size: size) ?? UIFont()
        }
        
        static func interBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Bold", size: size) ?? UIFont()
        }
    }
    
    enum Strings {
        enum Department: String {
            case all = "allTab.title"
            case android = "androidTab.title"
            case ios = "iosTab.title"
            case design = "designTab.title"
            case management = "managementTab.title"
            case qa = "qaTab.title"
            case backOffice = "backOfficeTab.title"
            case frontend = "frontendTab.title"
            case hr = "hrTab.title"
            case pr = "prTab.title"
            case backend = "backendTab.title"
            case support = "supportTab.title"
            case analytics = "analyticsTab.title"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum SearchBar: String {
            case placeholder = "placeholderSearchBar.title"
            case cancel = "cancelSearchBar.title"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum Filter: String {
            case title = "filter.title"
            case filterByAlphabet = "filterByAlphabet.text"
            case filterByBirthday = "filterByBirthday.text"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum NoInternet: String {
            case connectionError = "networkConnectionError.text"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum NoResult: String {
            case title = "noResult.title"
            case message = "noResult.text"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum Alert: String {
            case tryAgain = "tryAgainAlert.title"
            case title = "alert.title"
            case message = "messageAlert.text"
            
            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
    }
}
