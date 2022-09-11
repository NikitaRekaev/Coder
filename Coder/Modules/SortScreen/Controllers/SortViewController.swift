import UIKit

protocol SortDelegate: AnyObject {
    
    func sortByAlphabet()
    func sortByBirthday()
    func showBirthday(shouldShow: Bool)
}

class SortViewController: BaseViewController<SortView> {
    
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
        mainView.alphabetSortButton.addTarget(self, action:
                                                #selector(self.alphabetSortButtonClicked), for: .touchUpInside)
        mainView.birthdaySortButton.addTarget(self, action:
                                                #selector(self.birthdaySortButtonClicked), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension SortViewController {
    
    func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func alphabetSortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = true
        mainView.birthdaySortButton.isSelected = false
        dismiss(animated: true)
        delegate?.showBirthday(shouldShow: false)
        delegate?.sortByAlphabet()
    }
    
    func birthdaySortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = false
        mainView.birthdaySortButton.isSelected = true
        dismiss(animated: true)
        delegate?.showBirthday(shouldShow: true)
        delegate?.sortByBirthday()
    }
}
