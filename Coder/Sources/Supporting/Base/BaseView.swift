import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Method for customizing a visual
    func configureAppearance() { }
    
    /// Method for adjusting the position of the view on the screen
    func configureUI() { }
}
