import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var mainView: View { view as! View }
    
    override func loadView() {
            view = View()
    }
}
