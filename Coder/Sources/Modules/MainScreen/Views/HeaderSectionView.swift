import UIKit

final class HeaderSectionView: BaseView {
    
    // MARK: - Views
    
    private let backgroundView = UIView()
    private let yearLabel = HeaderSectionView.makeYearLabel()
    private let rightLine = HeaderSectionView.makeLine()
    private let leftLine = HeaderSectionView.makeLine()
    
    // MARK: - Appearance
    
    override func setup() {
        setConstraints()
    }
}

//MARK: - Create SubViews

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

// MARK: - Private Methods

private extension HeaderSectionView {
    
    func setConstraints() {
        [yearLabel, rightLine, leftLine].forEach { addSubview($0) }
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.Label.centerY),
            yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            leftLine.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Line.leading),
            leftLine.heightAnchor.constraint(equalToConstant: Constants.Line.height),
            leftLine.widthAnchor.constraint(equalToConstant: Constants.Line.width)
        ])
        
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Line.trailing),
            rightLine.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor),
            rightLine.heightAnchor.constraint(equalToConstant: Constants.Line.height),
            rightLine.widthAnchor.constraint(equalToConstant: Constants.Line.width)
        ])
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
