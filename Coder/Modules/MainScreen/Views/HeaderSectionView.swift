import UIKit

class HeaderSectionView: BaseView {
    private let yearLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Inter-SemiBold", size: 15)
        view.text = "2023"
        view.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        view.contentMode = .scaleAspectFit
        view.textAlignment = .center
        return view
    }()
    private let rightLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        return view
    }()
    private let leftLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        return view
    }()
    override func setup() {
        addSubview(yearLabel)
        addSubview(rightLine)
        addSubview(leftLine)
        setupConstraints()
    }
    func setupConstraints() {
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
