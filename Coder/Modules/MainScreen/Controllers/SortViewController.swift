import UIKit

protocol SortDelegate: AnyObject {
    
    func sortByAlphabet()
    func sortByBirthday()
    func showBirthday(shouldShow: Bool)
}

class SortViewController: BaseViewController<SortView> {
    
    weak var delegate: SortDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.alphabetSortButton.addTarget(self, action:
                                                #selector(self.alphabetSortButtonClicked(_:)), for: .touchUpInside)
        mainView.birthdaySortButton.addTarget(self, action:
                                                #selector(self.birthdaySortButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func alphabetSortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = true
        mainView.birthdaySortButton.isSelected = false
        dismiss(animated: true)
        delegate?.showBirthday(shouldShow: false)
        delegate?.sortByAlphabet()
    }
    
    @objc private func birthdaySortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = false
        mainView.birthdaySortButton.isSelected = true
        dismiss(animated: true)
        delegate?.showBirthday(shouldShow: true)
        delegate?.sortByBirthday()
    }
}
