import UIKit

final class UserTableView: UITableView {
    
    // MARK: - Internal Properties
    
    private var refreshController: UIRefreshControl?
    
    // MARK: - UITableView
    
    convenience init(refreshController: UIRefreshControl) {
        self.init(frame: .zero, style: .grouped)
        self.refreshController = refreshController
        setupUI()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension UserTableView {
    
    func setupUI() {
        backgroundColor = .none
        separatorStyle = .none
        refreshControl = refreshController
        showsVerticalScrollIndicator = false
    }
}
