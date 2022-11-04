import UIKit

protocol SortDelegate: AnyObject {
    
    func sortByAlphabet()
    func sortByBirthday()
    func showBirthday(shouldShow: Bool)
}

final class SortViewController: BaseViewController<SortView> {
    
    // MARK: - Delegate Properties
    
    weak var delegate: SortDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
}

// MARK: - Private Methods

private extension SortViewController {
    func setupTargets() {
        mainView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        mainView.sortButtonArray.forEach { sortButton in
            sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        }
    }
}

// MARK: - Actions

@objc
private extension SortViewController {
    
    func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func sortButtonClicked(_ sender: SortButton) {
        
        mainView.sortButtonArray.forEach { sortButton in
            if sortButton == sender {
                return sortButton.isSelected = true
            }
            sortButton.isSelected = false
        }
        
        switch(sender.model) {
        case .alphabet: alphabetSortButtonClicked(sender)
        case .birhDate: birthdaySortButtonClicked(sender)
        case .none: return
        }
        
        dismiss(animated: true)
    }
    
    func alphabetSortButtonClicked(_ sender: UIButton) {
        delegate?.showBirthday(shouldShow: false)
        delegate?.sortByAlphabet()
    }
    
    func birthdaySortButtonClicked(_ sender: UIButton) {
        delegate?.showBirthday(shouldShow: true)
        delegate?.sortByBirthday()
    }
}
