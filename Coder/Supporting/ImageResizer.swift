import UIKit

extension UIImage {
    func resized(_ targetSize: CGSize) -> UIImage! {
        let currentSize = self.size
        let widthRatio = targetSize.width / currentSize.width
        let heightRatio = targetSize.height / currentSize.height
        let newSize = CGSize(width: currentSize.width * widthRatio, height: currentSize.height * heightRatio)
        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
