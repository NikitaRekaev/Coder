import UIKit

class GrayCircleView: BaseView {
    
    // MARK: - Views
    
    let spinnignCircle = CAShapeLayer()
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        let rect = self.bounds
        let circlarPath = UIBezierPath(ovalIn: rect)
        
        spinnignCircle.path = circlarPath.cgPath
        spinnignCircle.fillColor = UIColor.clear.cgColor
        spinnignCircle.strokeColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1).cgColor
        spinnignCircle.lineWidth = 2
        spinnignCircle.lineCap = .round
        
        self.layer.addSublayer(spinnignCircle)
    }
}
