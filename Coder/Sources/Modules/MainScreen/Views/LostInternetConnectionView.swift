import UIKit

final class LostInternetConnectionView: BaseView {
    
    let tryAgainButton = UIButton()
    
    private let NLOImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: Private methods

private extension LostInternetConnectionView {
    
    func setupUI() {
        NLOImageView.image = UIImage(named: "NLO")
        NLOImageView.clipsToBounds = true
        NLOImageView.layer.borderWidth = 0
        
        titleLabel.text = "Какой-то сверхразум всё сломал"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "SemiBold", size: 17)
        titleLabel.textColor = UIColor(red: 0.05, green: 0.05, blue: 0.16, alpha: 1)
        
        subTitleLabel.text = "Постараемся быстро починить"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont(name: "Regular", size: 16)
        subTitleLabel.textColor = UIColor(red: 151/255, green: 151/255, blue: 155/255, alpha: 1)
        
        tryAgainButton.backgroundColor = .clear
        tryAgainButton.setTitle("Попробовать снова", for: .normal)
        tryAgainButton.setTitleColor(UIColor(red: 101/255, green: 52/255, blue: 1, alpha: 1), for: .normal)
        tryAgainButton.setTitle("Меня нажали", for: .highlighted)
        tryAgainButton.titleLabel?.font = UIFont(name: "SemiBold", size: 17)
    }
    
    func setupConstraints() {
        [NLOImageView, titleLabel, subTitleLabel, tryAgainButton].forEach { addSubview($0) }
        
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