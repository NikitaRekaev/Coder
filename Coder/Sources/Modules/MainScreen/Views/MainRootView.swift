import UIKit

final class MainRootView: BaseView {
    
    // MARK: - Views
    
    let searchBar = SearchBar()
    let topTabsCollectionView = TopTabsCollectionView()
    let refreshControl = UIRefreshControl()
    let errorView = UnknownErrorView()
    
    lazy var userTableView = UserTableView(refreshController: refreshControl)
    
    private let searchErrorView = SearchErrorView()
    private let separatorLineUnderTabs = UIView()
    
    // MARK: - Setup
    
    override func setup() {
        configureUI()
        setConstraints()
    }
}

// MARK: SetView

extension MainRootView {
    
    func setSearchErrorView(error: Bool) {
        searchErrorView.isHidden = !error
    }
    
    func setErrorView(error: Bool) {
        errorView.isHidden = !error
        searchBar.isHidden = error
    }
}

// MARK: Private methods

private extension MainRootView {
    
    func configureUI() {
        backgroundColor = .white
        searchErrorView.isHidden = true
        separatorLineUnderTabs.backgroundColor = R.Colors.separator
    }
    
    func setConstraints() {
        [userTableView, separatorLineUnderTabs, topTabsCollectionView, searchErrorView, errorView].forEach {
            addSubview($0)
        }
        
        topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: Constants.tabsHeight)
        ])
        
        separatorLineUnderTabs.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLineUnderTabs.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor),
            separatorLineUnderTabs.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineUnderTabs.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineUnderTabs.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        ])
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: separatorLineUnderTabs.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        searchErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchErrorView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor),
            searchErrorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchErrorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchErrorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Constants

private enum Constants {
    static let tabsHeight: CGFloat = 36
    static let separatorHeight: CGFloat = 0.33
}
