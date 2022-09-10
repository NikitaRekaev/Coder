import UIKit

class HeaderSectionView: BaseView {
    
    private let yearLabel = UILabel()
    private let rightLine = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    private let leftLine = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(yearLabel)
        yearLabel.font = UIFont(name: "Inter-SemiBold", size: 15)
        yearLabel.text = "2023"
        yearLabel.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        yearLabel.contentMode = .scaleAspectFit
        yearLabel.textAlignment = .center
        
        addSubview(rightLine)
        rightLine.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        
        addSubview(leftLine)
        leftLine.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
    }
    
    private func setupConstraints() {
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
