import UIKit

class BaseViewController<T: UIView>: UIViewController {
    var mainView: T { view as! T }
    override func loadView() {
            view = T()
    }
}
