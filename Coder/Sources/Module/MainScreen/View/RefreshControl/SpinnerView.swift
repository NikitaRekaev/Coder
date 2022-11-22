import UIKit

final class SpinnerView: UIView {
    
    // MARK: - Constants

    private enum Constants {
        
        static let lineWidth: CGFloat = 2
        static let duration: Double = 5
        static let countAnimate: Int = 36
    }
    
    // MARK: - Lifecycle
    
    override var layer: CAShapeLayer {
        get {
            return super.layer as? CAShapeLayer ?? CAShapeLayer()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = R.Colors.violet.cgColor
        layer.lineWidth = Constants.lineWidth
        setPath()
    }
    
    override func didMoveToWindow() {
        animate()
    }
}

// MARK: - Internal Properties

private extension SpinnerView {
    
    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }
    
    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(0.6, 0.500, 0.5),
                Pose(0.6, 1.000, 0.3),
                Pose(0.6, 1.500, 0.1),
                Pose(0.2, 1.875, 0.1),
                Pose(0.2, 2.250, 0.3),
                Pose(0.2, 2.625, 0.5),
                Pose(0.2, 3.000, 0.7)
            ]
        }
    }
}

// MARK: - Private Methods

private extension SpinnerView {
    
    func setPath() {
        let rect = self.bounds
        let circlarPath = UIBezierPath(ovalIn: rect)
        layer.path = circlarPath.cgPath
    }
    
    func animate() {
        var time: CFTimeInterval = .zero
        var times = [CFTimeInterval]()
        var start: CGFloat = .zero
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(.zero) { $0 + $1.secondsSincePriorPose }
        
        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * Constants.lineWidth * .pi)
            strokeEnds.append(pose.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[.zero])
        strokeEnds.append(strokeEnds[.zero])
        
        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
        
        animateStrokeHueWithDuration(duration: totalSeconds * Constants.duration)
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
    func animateStrokeHueWithDuration(duration: CFTimeInterval) {
        let count = Constants.countAnimate
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.keyTimes = (.zero ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
        animation.duration = duration
        animation.calculationMode = .linear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}
