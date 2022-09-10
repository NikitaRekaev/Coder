import UIKit
import SkeletonView

class MainRootView: BaseView {
    
    let errorView = LostInternetConnectionView()
    let userTableView = UITableView()
    let searchBar = UISearchBar()
    
    let notFoundSearchView: NotFoundOnSearchView = {
        let view = NotFoundOnSearchView()
        view.isHidden = true
        return view
    }()
    
    let topTabsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let tab = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tab.backgroundColor = .clear
        return tab
    }()
    
    private let separatorLineUnderTabs: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.33))
        view.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        return view
    }()
    
    override func setup() {
        backgroundColor = .white
        userTableView.backgroundColor = .white
        
        addSubview(userTableView)
        addSubview(notFoundSearchView)
        addSubview(topTabsCollectionView)
        addSubview(separatorLineUnderTabs)
        addSubview(errorView)

        userTableView.isSkeletonable = true
        setupConstraints()
        setViewDependingOnConnection()
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
    
    func setupSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(
            red: 247.0/255.0,
            green: 247.0/255.0,
            blue: 248.0/255.0,
            alpha: 1)
        
        searchBar.setImage(
            UIImage(named: "list-ui-alt"),
            for: .bookmark,
            state: .normal
        )
        
        searchBar.setImage(
            UIImage(named: "list-ui-alt_selected"),
            for: .bookmark,
            state: .selected
        )
        
        searchBar.tintColor = #colorLiteral(red: 0.4257887602, green: 0.1908605397, blue: 1, alpha: 1)
        searchBar.backgroundColor = .white
        searchBar.showsBookmarkButton = true
        searchBar.sizeToFit()
        searchBar.placeholder = "Введи имя, тег, почту..."
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
    }
    
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
