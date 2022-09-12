import UIKit

final class SortView: BaseView {
    
    // MARK: - Properties
    
    let alphabetSortButton = UIButton()
    let birthdaySortButton = UIButton()
    let backButton = UIButton()
    
    private let titleLabel = UILabel()
    
    // MARK: - Initilization
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: - Private Methods

private extension SortView {
    
    func setupUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.text = "Сортировка"
        titleLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        titleLabel.font = UIFont(name: "Inter-SemiBold", size: 20)
        
        addSubview(backButton)
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        
        addSubview(alphabetSortButton)
        alphabetSortButton.setTitle("По алфавиту", for: .normal)
        alphabetSortButton.setImage(UIImage(named: "unChecked"), for: .normal)
        alphabetSortButton.setImage(UIImage(named: "isChecked"), for: .selected)
        alphabetSortButton.setTitleColor(.black, for: .normal)
        alphabetSortButton.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        alphabetSortButton.titleEdgeInsets.left = 14
        
        addSubview(birthdaySortButton)
        birthdaySortButton.setTitle("По дню рождения", for: .normal)
        birthdaySortButton.setImage(UIImage(named: "unChecked"), for: .normal)
        birthdaySortButton.setImage(UIImage(named: "isChecked"), for: .selected)
        birthdaySortButton.setTitleColor(.black, for: .normal)
        birthdaySortButton.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        birthdaySortButton.titleEdgeInsets.left = 14
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21.5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.87)
        ])
        
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
