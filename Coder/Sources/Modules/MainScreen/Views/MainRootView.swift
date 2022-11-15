import UIKit

final class MainRootView: BaseView {
    
    // MARK: - Views
    
    let searchBar = SearchBar()
    let topTabsCollectionView = TopTabsCollectionView()
    let refreshControl = UIRefreshControl()
    let internalErrorView = InternalErrorView()
    
    lazy var userTableView = UserTableView(refreshController: refreshControl)
    
    private let searchErrorView = SearchErrorView()
    private let separatorLineUnderTabs = UIView()
    private let grayCircleView = GrayCircleView(frame: Constants.refreshSubViewFrame)
    private let spinnerView = SpinnerView(frame: Constants.refreshSubViewFrame)
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        backgroundColor = .white
        
        searchErrorView.isHidden = true
        separatorLineUnderTabs.backgroundColor = R.Colors.separator
        
        refreshControl.tintColor = .clear
    }
    
    override func configureUI() {
        addSubView()
        
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: Constants.tabsHeight),
            
            separatorLineUnderTabs.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor),
            separatorLineUnderTabs.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineUnderTabs.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineUnderTabs.heightAnchor.constraint(equalToConstant: Constants.separatorHeight),
            
            userTableView.topAnchor.constraint(equalTo: separatorLineUnderTabs.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchErrorView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor),
            searchErrorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchErrorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchErrorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            internalErrorView.topAnchor.constraint(equalTo: topAnchor),
            internalErrorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            internalErrorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            internalErrorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: SetView

extension MainRootView {
    
    func setSearchErrorView(error: Bool) {
        searchErrorView.isHidden = !error
    }
    
    func setErrorView(error: Bool) {
        internalErrorView.isHidden = !error
        searchBar.isHidden = error
    }
}

// MARK: - Private  Methods

private extension MainRootView {
    
    func addSubView() {
        
        [userTableView,
         separatorLineUnderTabs,
         topTabsCollectionView,
         searchErrorView,
         internalErrorView].forEach { addView($0) }
        
        [grayCircleView, spinnerView].forEach { refreshControl.addView($0) }
    }
}

// MARK: - Constants

private enum Constants {
    static let tabsHeight: CGFloat = 36
    static let separatorHeight: CGFloat = 0.33
    static let refreshSubViewFrame = CGRect(x: UIScreen.main.bounds.width / 2.1, y: 20, width: 20, height: 20)
}
