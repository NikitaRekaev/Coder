import UIKit

class MainRootView: BaseView {
    
    let errorView = LostInternetConnectionView()
    let userTableView = UITableView()
    let searchBar = SearchBar()
    
    private let notFoundSearchView = NotFoundOnSearchView()
    private let separatorLineUnderTabs = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.33))
    
    let topTabsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let tab = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tab.backgroundColor = .clear
        return tab
    }()
    
    override func setup() {
        setupUI()
        setupConstraints()
        setViewDependingOnConnection()
    }
}

// MARK: SetView

extension MainRootView {
    
    func setNotFoundView() {
        userTableView.isHidden = true
        notFoundSearchView.isHidden = false
    }

    func setIsFoundView() {
        notFoundSearchView.isHidden = true
        userTableView.isHidden = false
    }

    func setErrorView() {
        userTableView.isHidden = true
        topTabsCollectionView.isHidden = true
        searchBar.isHidden = true
        errorView.isHidden = false
    }

    func setMainView() {
        errorView.isHidden = true
        userTableView.isHidden = false
        topTabsCollectionView.isHidden = false
        searchBar.isHidden = false
    }

}

// MARK: Private methods

extension MainRootView {
    
    private func setViewDependingOnConnection() {
        NetworkMonitor.shared.startMonitoring()
        print("T/f \(NetworkMonitor.shared.isConnected)")
        print("Проверка интернета")
        
        if NetworkMonitor.shared.isConnected {
            print("Интернет присутствует")
            errorView.isHidden = true
            userTableView.isHidden = false
            topTabsCollectionView.isHidden = false
        } else {
            print("Интернет отсутствует")
            userTableView.isHidden = true
            topTabsCollectionView.isHidden = true
            errorView.isHidden = false
        }
        
        NetworkMonitor.shared.stopMonitoring()
    }

    private func setupUI() {
        backgroundColor = .white
        
        addSubview(userTableView)
        userTableView.backgroundColor = .white
        
        addSubview(notFoundSearchView)
        notFoundSearchView.isHidden = true
        
        addSubview(topTabsCollectionView)
        
        addSubview(separatorLineUnderTabs)
        separatorLineUnderTabs.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        
        addSubview(errorView)
    }

    private func setupConstraints() {
        topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 96),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        separatorLineUnderTabs.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLineUnderTabs.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 0),
            separatorLineUnderTabs.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineUnderTabs.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineUnderTabs.heightAnchor.constraint(equalToConstant: 0.33)
        ])
        
        notFoundSearchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notFoundSearchView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 22),
            notFoundSearchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            notFoundSearchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notFoundSearchView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 0),
            userTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
