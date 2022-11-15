import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
          self.addSubview(view)
          view.translatesAutoresizingMaskIntoConstraints = false
    }
}
