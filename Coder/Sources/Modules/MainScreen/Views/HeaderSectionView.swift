import UIKit

final class HeaderSectionView: BaseView {
    
    // MARK: - Views
    
    private let backgroundView = UIView()
    private let yearLabel = HeaderSectionView.makeYearLabel()
    private let rightLine = HeaderSectionView.makeLine()
    private let leftLine = HeaderSectionView.makeLine()
     
    // MARK: - Setting View
     
     override func setViewPosition() {
         [yearLabel, rightLine, leftLine].forEach { addView($0) }
         
         NSLayoutConstraint.activate([
             yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.Label.centerY),
             yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
             
             leftLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
             leftLine.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
             leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Line.leading),
             leftLine.heightAnchor.constraint(equalToConstant: Constants.Line.height),
             leftLine.widthAnchor.constraint(equalToConstant: Constants.Line.width),
             
             rightLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
             rightLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Line.trailing),
             rightLine.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor),
             rightLine.heightAnchor.constraint(equalToConstant: Constants.Line.height),
             rightLine.widthAnchor.constraint(equalToConstant: Constants.Line.width)
         ])
     }
}

// MARK: - Create SubViews

private extension HeaderSectionView {
    
    static func makeYearLabel() -> UILabel {
        let yearLabel = UILabel()
        
        yearLabel.text = Constants.Label.text
        yearLabel.font = Constants.Label.font
        yearLabel.textColor = R.Colors.separator
        yearLabel.contentMode = .scaleAspectFit
        yearLabel.textAlignment = .center
        
        return yearLabel
    }
    
    static func makeLine() -> UIView {
        let line = UIView()
        line.backgroundColor = R.Colors.separator
        return line
    }
}

// MARK: - Constants

private enum Constants {
    
    enum Label {
        static let text = "\(Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year! + 1)"
        static let font = R.Fonts.interMedium(with: 15)
        static let centerY: CGFloat = -15
    }
    
    enum Line {
        static let leading: CGFloat = 24
        static let trailing: CGFloat = -24
        static let height: CGFloat = 1
        static let width: CGFloat = 72
    }
}
