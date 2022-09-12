import UIKit

final class BirthView: BaseView {
    
    private let birthView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
    private let starImageView = UIImageView()
    private let birthDataLabel = UILabel()
    private let yearsLabel = UILabel()
    private let dividingLine = UIView(frame: .zero)
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
    
    func setData(dateBirth: String, years: String) {
        self.birthDataLabel.text = "\(dateBirth)"
        self.yearsLabel.text = "\(years)"
    }
}

// MARK: - Private Methods

private extension BirthView {
    
    func setupUI() {
        addSubview(birthView)
        
        addSubview(starImageView)
        starImageView.image = UIImage(named: "star")
        starImageView.layer.borderWidth = 0
        
        addSubview(birthDataLabel)
        birthDataLabel.textColor = .black
        birthDataLabel.font = UIFont(name: "Inter-Medium", size: 16)
        
        addSubview(yearsLabel)
        yearsLabel.textColor = .black
        yearsLabel.font = UIFont(name: "Inter-Medium", size: 16)
        
        addSubview(dividingLine)
        dividingLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
    }
    
    func setupConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.centerYAnchor.constraint(equalTo: birthView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        birthDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthDataLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            birthDataLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 14)
        ])
        
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearsLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            yearsLabel.trailingAnchor.constraint(equalTo: birthView.trailingAnchor, constant: -20)
        ])
        
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: yearsLabel.bottomAnchor, constant: 27.5),
            dividingLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividingLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dividingLine.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 32.0),
            dividingLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
