import UIKit

class BaseViewController<T: UIView>: UIViewController {
    // swiftlint:disable force_cast
    var mainView: T { view as! T }
    // swiftlint:enable force_cast
    override func loadView() {
            view = T()
    }
}
