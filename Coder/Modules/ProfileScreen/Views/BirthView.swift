import UIKit

class BirthView: BaseView {
    private let birthView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
        return view
    }()
    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "star")
        view.layer.borderWidth = 0
        return view
    }()
    private let birthDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()
    private let yearsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()
    private let dividingLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(birthView)
        addSubview(starImageView)
        addSubview(birthDataLabel)
        addSubview(yearsLabel)
        addSubview(dividingLine)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   private func setupConstraints() {
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
    func setData(dateBirth: String, years: String) {
        self.birthDataLabel.text = "\(dateBirth)"
        self.yearsLabel.text = "\(years)"
    }
}
