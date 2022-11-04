import UIKit

protocol SortDelegate: AnyObject {
    
    func sort(model: SortModel)
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
        
        delegate?.showBirthday(shouldShow: sender.model == .birhDate)
        delegate?.sort(model: sender.model)
        dismiss(animated: true)
    }
}
