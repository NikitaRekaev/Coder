import UIKit

final class GrayCircleView: BaseView {
    
    // MARK: - Views
    
    private let spinnignCircle = CAShapeLayer()
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        let rect = self.bounds
        let circlarPath = UIBezierPath(ovalIn: rect)
        
        spinnignCircle.path = circlarPath.cgPath
        spinnignCircle.fillColor = UIColor.clear.cgColor
        spinnignCircle.strokeColor = R.Colors.profileBackground.cgColor
        spinnignCircle.lineWidth = CGFloat(integerLiteral: .two)
        spinnignCircle.lineCap = .round
        
        self.layer.addSublayer(spinnignCircle)
    }
}
