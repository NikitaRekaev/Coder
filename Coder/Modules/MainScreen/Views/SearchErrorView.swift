import UIKit

final class SearchErrorView: BaseView {
    
    private let loupe = UIImageView()
    private let userNotFoundLabel = UILabel()
    private let tryToCorrectLabel = UILabel()
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(loupe)
        loupe.image = UIImage(named: "loupe")
        
        addSubview(userNotFoundLabel)
        userNotFoundLabel.text = "Мы никого не нашли"
        userNotFoundLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        userNotFoundLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        userNotFoundLabel.contentMode = .scaleAspectFit
        userNotFoundLabel.textAlignment = .center
        
        addSubview(tryToCorrectLabel)
        tryToCorrectLabel.text = "Попробуйте скорректировать запрос"
        tryToCorrectLabel.font = UIFont(name: "Inter-Regular", size: 16)
        tryToCorrectLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        tryToCorrectLabel.contentMode = .scaleAspectFit
        tryToCorrectLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        loupe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loupe.centerXAnchor.constraint(equalTo: centerXAnchor),
            loupe.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            loupe.widthAnchor.constraint(equalToConstant: 56),
            loupe.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        userNotFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNotFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNotFoundLabel.topAnchor.constraint(equalTo: loupe.bottomAnchor, constant: 8)
        ])
        
        tryToCorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryToCorrectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryToCorrectLabel.topAnchor.constraint(equalTo: userNotFoundLabel.bottomAnchor, constant: 12)
        ])
    }
}
