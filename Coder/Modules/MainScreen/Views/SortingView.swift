import UIKit

class SortView: BaseView {
    let alphabetSortButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "UnChecked"), for: .normal)
        button.setBackgroundImage(UIImage(named: "isChecked"), for: .selected)
        button.titleLabel?.text = "По алфавиту"
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        return button
    }()
    let birthdaySortButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "UnChecked"), for: .normal)
        button.setBackgroundImage(UIImage(named: "isChecked"), for: .selected)
        button.titleLabel?.text = "По дню рождения"
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        return button
     }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировка"
        label.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        label.font = UIFont(name: "Inter-SemiBlond", size: 20)
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
            alphabetSortButton.topAnchor.constraint(equalTo: topAnchor, constant: 84),
            alphabetSortButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18)
        ])
        birthdaySortButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthdaySortButton.topAnchor.constraint(equalTo: alphabetSortButton.bottomAnchor, constant: 40),
            birthdaySortButton.leadingAnchor.constraint(equalTo: alphabetSortButton.leadingAnchor)
        ])
    }
}
