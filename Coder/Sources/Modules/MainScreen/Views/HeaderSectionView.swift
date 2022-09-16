import UIKit

final class HeaderSectionView: BaseView {
    
    private let backgroundView = UIView()
    private let yearLabel = UILabel()
    private let rightLine = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    private let leftLine = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: - Private Methods

private extension HeaderSectionView {
    
    func setupUI() {
        yearLabel.font = UIFont(name: "Inter-SemiBold", size: 15)
        yearLabel.text = "\(Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year! + 1)"
        yearLabel.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        yearLabel.contentMode = .scaleAspectFit
        yearLabel.textAlignment = .center
        
        rightLine.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        leftLine.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
    }
    
    func setupConstraints() {
        [yearLabel, rightLine, leftLine].forEach { addSubview($0) }
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15),
            yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            leftLine.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            leftLine.widthAnchor.constraint(equalToConstant: 72)
        ])
        
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            rightLine.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor),
            rightLine.heightAnchor.constraint(equalToConstant: 1),
            rightLine.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
}
