import UIKit

class EmployeeListRootView: BaseView {
    let globalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 0.16)
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
    let employeeTableView = UITableView()
    let searchBar = UISearchBar()
    let notFoundSearchView: NotFoundOnSearchView = {
        let view = NotFoundOnSearchView()
        view.isHidden = true
        return view
    }()
    let errorView = LostInternetConnectionView()
    override func setup() {
        backgroundColor = .white
        employeeTableView.backgroundColor = .white
        addSubview(employeeTableView)
        addSubview(notFoundSearchView)
        addSubview(topTabsCollectionView)
        addSubview(separatorLineUnderTabs)
        addSubview(errorView)
        addSubview(globalView)
        setupConstraints()
        setViewDependingOnConnection()
    }
    private func setupConstraints() {
        globalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            globalView.topAnchor.constraint(equalTo: topAnchor),
            globalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            globalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            globalView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
        separatorLineUnderTabs.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLineUnderTabs.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 7.67),
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
        employeeTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeTableView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 22),
            employeeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            employeeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            employeeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
            employeeTableView.isHidden = false
            topTabsCollectionView.isHidden = false
        } else {
            print("Интернет отсутствует")
            employeeTableView.isHidden = true
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
        searchBar.tintColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        searchBar.setImage(
            UIImage(named: "list-ui-alt"),
            for: .bookmark,
            state: .normal
        )
        searchBar.backgroundColor = .white
        searchBar.showsBookmarkButton = true
        searchBar.placeholder = "Введи имя, тег, почту..."
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
    }
    func setDimView(_ shouldSet: Bool) {
        shouldSet ? (globalView.isHidden = false) : (globalView.isHidden = true)
    }
    func setNotFoundView() {
        employeeTableView.isHidden = true
        notFoundSearchView.isHidden = false
    }
    func setIsFoundView() {
        notFoundSearchView.isHidden = true
        employeeTableView.isHidden = false
    }
    func setErrorView() {
        employeeTableView.isHidden = true
        topTabsCollectionView.isHidden = true
        searchBar.isHidden = true
        errorView.isHidden = false
    }
    func setMainView() {
        errorView.isHidden = true
        employeeTableView.isHidden = false
        topTabsCollectionView.isHidden = false
        searchBar.isHidden = false
    }
}
