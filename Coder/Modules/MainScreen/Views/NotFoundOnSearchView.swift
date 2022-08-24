import UIKit

class NotFoundOnSearchView: BaseView {
    private let loupe: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loupe")
        return view
    }()
    private let employeeNotFoundLabel: UILabel = {
        let view = UILabel()
        view.text = "Мы никого не нашли"
        view.font = UIFont(name: "Inter-SemiBold", size: 17)
        view.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        view.contentMode = .scaleAspectFit
        view.textAlignment = .center
        return view
    }()
    private let tryToCorrectLabel: UILabel = {
        let view = UILabel()
        view.text = "Попробуйте скорректировать запрос"
        view.font = UIFont(name: "Inter-Regular", size: 16)
        view.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        view.contentMode = .scaleAspectFit
        view.textAlignment = .center
        return view
    }()

    override func setup() {
        addSubview(loupe)
        addSubview(employeeNotFoundLabel)
        addSubview(tryToCorrectLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        loupe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loupe.centerXAnchor.constraint(equalTo: centerXAnchor),
            loupe.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            loupe.widthAnchor.constraint(equalToConstant: 56),
            loupe.heightAnchor.constraint(equalToConstant: 56)
        ])
        employeeNotFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeNotFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            employeeNotFoundLabel.topAnchor.constraint(equalTo: loupe.bottomAnchor, constant: 8)
        ])
        tryToCorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryToCorrectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryToCorrectLabel.topAnchor.constraint(equalTo: employeeNotFoundLabel.bottomAnchor, constant: 12)
        ])
    }

}
