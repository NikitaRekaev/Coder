import UIKit

class SortView: BaseView {
    let alphabetSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("По алфавиту", for: .normal)
        button.setImage(UIImage(named: "unChecked"), for: .normal)
        button.setImage(UIImage(named: "isChecked"), for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        button.titleEdgeInsets.left = 14
        return button
    }()
    let birthdaySortButton: UIButton = {
        let button = UIButton()
        button.setTitle("По дню рождения", for: .normal)
        button.setImage(UIImage(named: "unChecked"), for: .normal)
        button.setImage(UIImage(named: "isChecked"), for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        button.titleEdgeInsets.left = 14
        return button
     }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировка"
        label.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        return label
    }()
    override func setup() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(alphabetSortButton)
        addSubview(birthdaySortButton)
        setupConstraints()
    }
   private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
        alphabetSortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alphabetSortButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 41.5),
            alphabetSortButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            alphabetSortButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -214)
        ])
        birthdaySortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdaySortButton.topAnchor.constraint(equalTo: alphabetSortButton.bottomAnchor, constant: 35),
            birthdaySortButton.leadingAnchor.constraint(equalTo: alphabetSortButton.leadingAnchor),
            birthdaySortButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -172)
        ])
    }
}
