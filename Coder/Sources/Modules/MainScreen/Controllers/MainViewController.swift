import UIKit

final class MainViewController: BaseViewController<MainRootView> {
    
    // MARK: - Controllers
    
    private lazy var sortViewController = SortViewController()
    
    private lazy var networkErrorView = NetworkErrorView()
    
    // MARK: - Gestures
    
    private lazy var hideNoInternetOnTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNoInternerView))
    
    // MARK: - Internal Properties
    
    private lazy var shouldShowBirthday: Bool = false
    private lazy var model = MainModel()
    private lazy var tabs = Department.allCases
    private lazy var networkTask = NetworkTask()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortViewController.delegate = self
        setupNavigationItem()
        setupTopTabs()
        setupTableView()
        setupTargets()
        setupNetworkErrorView()
        setViewDependingOnConnection()
        networkTask.getData(from: "users", loadData(result:))
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchText = mainView.searchBar.text ?? ""
        mainView.setSearchErrorView(error: model.filteredUser.isEmpty)
        mainView.userTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.searchTextField.leftView = UIImageView(image: R.Images.SearchBar.leftImageNormal)
        mainView.searchBar.showsCancelButton = false
        mainView.searchBar.showsBookmarkButton = true
        mainView.searchBar.text = nil
        mainView.searchBar.endEditing(true)
        model.searchText = ""
        mainView.setSearchErrorView(error: false)
        mainView.userTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        present(sortViewController, animated: true)
    }
}

// MARK: - SortDelegate

extension MainViewController: SortDelegate {
    
    func sort(model: SortModel) {
        switch(model) {
        case .alphabet: self.model.users.sort(by: { $0.firstName < $1.firstName })
        case .birhDate: self.model.userSortByDate()
        }
        mainView.searchBar.setImage(R.Images.SearchBar.rightImageSelected, for: .bookmark, state: .normal)
        mainView.userTableView.reloadData()
    }
    
    func showBirthday(shouldShow: Bool) {
        self.shouldShowBirthday = shouldShow
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if model.selectedDepartment == tabs[indexPath.item] {
            model.selectedDepartment = nil
        } else {
            model.selectedDepartment = tabs[indexPath.item]
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        mainView.userTableView.reloadData()
        updateDepartmentSelection()
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopTabsCollectionViewCell.identifier,
            for: indexPath
        ) as? TopTabsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setModel(tabs[indexPath.item])
        cell.setCellSelected(tabs[indexPath.item] == model.selectedDepartment)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = tabs[indexPath.item].title
        label.sizeToFit()
        
        return CGSize(width: label.frame.width, height: mainView.topTabsCollectionView.frame.height)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.filteredUser.endIndex != .zero {
            let viewController = ProfileViewController()
            viewController.item = model.filteredUser[indexPath.item]
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section != .zero ? HeaderSectionView() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != .zero ? Constants.headerViewHeight : .zero
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.users.isEmpty {
            return Constants.skeletonCellCount
        } else {
            if self.shouldShowBirthday {
                return section == .zero ? model.thisYearBirthdayUser.count : model.nextYearBirthdayUser.count
            } else {
                return model.filteredUser.count
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.shouldShowBirthday ?  .two : .one
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier)
                as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        if !model.users.isEmpty {
            if shouldShowBirthday {
                let sortedUser = model.userModelForSections[indexPath.section][indexPath.row]
                cell.setImage(urlString: sortedUser.avatarUrl)
                cell.setData(firstName: sortedUser.firstName,
                             lastName: sortedUser.lastName,
                             tag: sortedUser.userTag.lowercased(),
                             department: sortedUser.department,
                             dateBirth: model.formatDate(date: sortedUser.birthdayDate))
            } else {
                let user = model.filteredUser[indexPath.row]
                
                cell.setImage(urlString: user.avatarUrl)
                cell.setData(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    tag: user.userTag.lowercased(),
                    department: user.department,
                    dateBirth: model.formatDate(date: user.birthdayDate)
                )
            }
            
            cell.setBirthdayLabelVisibility(shouldShowBirthday: self.shouldShowBirthday)
            cell.setSkeletonView(show: false)
            
        } else {
            cell.setSkeletonView(show: true)
        }
        
        return cell
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func setupTargets() {
        mainView.internalErrorView.tryAgainButton.addTarget(self, action: #selector(checkConnection), for: .touchUpInside)
        mainView.searchBar.searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        mainView.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func setupNavigationItem() {
        mainView.searchBar.delegate = self
        navigationItem.titleView = mainView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupNetworkErrorView() {
        networkErrorView.addGestureRecognizer(hideNoInternetOnTapGesture)
        
        navigationController?.view.addSubview(networkErrorView)
        networkErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            networkErrorView.heightAnchor.constraint(equalToConstant: 0)
        ])
    }
    
    func setupTopTabs() {
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        mainView.topTabsCollectionView.showsHorizontalScrollIndicator = false
        mainView.topTabsCollectionView.register(
            TopTabsCollectionViewCell.self,
            forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier
        )
    }
    
    func setupTableView() {
        mainView.userTableView.separatorColor = .clear
        mainView.userTableView.delegate = self
        mainView.userTableView.dataSource = self
        mainView.userTableView.register(UserTableViewCell.self,
                                        forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func setViewDependingOnConnection() {
        if NetworkMonitor.shared.isConnected {
            mainView.setErrorView(error: false)
        } else {
            mainView.setErrorView(error: true)
        }
        
        NetworkMonitor.shared.stopMonitoring()
    }
    
    func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == model.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
    
    func loadData(result: Result<UserModel, Error>) {
        switch result {
        case let .success(responseData):
            self.model.users = responseData.items
            shouldNetworkErrorViewBePresented(true)
//            self.mainView.setErrorView(error: false)
            self.mainView.userTableView.reloadData()
        case .failure(_:):
            shouldNetworkErrorViewBePresented(true)
//            self.mainView.setErrorView(error: true)
        }
    }
    
    func pullRefresh(result: Result<UserModel, Error>) {
        loadData(result: result)
        self.mainView.refreshControl.endRefreshing()
    }
    
    func shouldNetworkErrorViewBePresented(_ shouldPresenet: Bool) {
        networkErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            networkErrorView.heightAnchor.constraint(equalToConstant: shouldPresenet ? navigationBarbarContentStart : .zero)])
        
        networkErrorView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5) { self.networkErrorView.layoutIfNeeded() } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    guard self.networkErrorView.frame.height != self.navigationBarbarContentStart else {
                        self.shouldNetworkErrorViewBePresented(false)
                        return
                    }
                }
            }
        }
    }
}

// MARK: - Actions

@objc
private extension MainViewController {
    
    func textChanged(_ sender: UITextField) {
        let image = sender.text?.count == .zero ? R.Images.SearchBar.leftImageNormal :
        R.Images.SearchBar.leftImageSelected
        sender.leftView = UIImageView.init(image: image)
    }
    
    func didPullToRefresh(_ sender: UIRefreshControl) {
        self.mainView.setErrorView(error: false)
        shouldShowBirthday = false
        networkTask.getData(from: "users", pullRefresh(result:))
    }
    
    func checkConnection(_ sender: UIButton) {
        self.mainView.setErrorView(error: false)
        networkTask.getData(from: "users", loadData(result:))
    }
    
    func didTapNoInternerView(_ sender: UITapGestureRecognizer) {
        shouldNetworkErrorViewBePresented(false)
    }
}

// MARK: - Constants

private enum Constants {
    static let skeletonCellCount: Int = 15
    static let rowCellHeight: CGFloat = 84
    static let headerViewHeight: CGFloat = 68
}

extension UIViewController {
    
    var navigationBarbarContentStart: CGFloat {
        navigationBarTopOffset + navigationBarHeight
    }
    var navigationBarTopOffset: CGFloat {
        navigationController?.navigationBar.frame.origin.y ?? .zero
    }
    
    var navigationBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? .zero
    }
}
