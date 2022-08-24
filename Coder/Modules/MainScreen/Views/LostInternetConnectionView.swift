import UIKit

class LostInternetConnectionView: BaseView {
    private let NLOImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NLO")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Какой-то сверхразум всё сломал"
        label.numberOfLines = 0
        label.font = UIFont(name: "SemiBold", size: 17)
        label.textColor = UIColor(red: 0.05, green: 0.05, blue: 0.16, alpha: 1)
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Постараемся быстро починить"
        label.numberOfLines = 0
        label.font = UIFont(name: "Regular", size: 16)
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 155/255, alpha: 1)
        return label
    }()
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Попробовать снова", for: .normal)
        button.setTitleColor(UIColor(red: 101/255, green: 52/255, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Меня нажали", for: .highlighted)
        button.titleLabel?.font = UIFont(name: "SemiBold", size: 17)
        return button
    }()

    override func setup() {
        addSubview(NLOImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(tryAgainButton)
        setupConstraints()
    }
    private func setupConstraints() {
        NLOImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NLOImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            NLOImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: NLOImageView.bottomAnchor, constant: 8)
        ])
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ])
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 12)
        ])
    }

}
