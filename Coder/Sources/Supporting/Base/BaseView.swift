import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewAppearance()
        setViewPosition()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Method for customizing a visual
    func setViewAppearance() { }
    
    /// Method for adjusting the position of the view on the screen
    func setViewPosition() { }
}
