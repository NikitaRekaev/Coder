import UIKit

final class MainViewController: BaseViewController<MainRootView> {
    
    // MARK: - Network
    
    private lazy var networkTask = NetworkTask()
    
    // MARK: - Controllers
    
    private lazy var sortViewController = SortViewController()
    
    // MARK: - Models
    
    private lazy var model = MainModel()
    private lazy var tabs = Department.allCases
    
    // MARK: - Internal Properties
    
    private lazy var shouldShowBirthday: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenSettings()
        networkTask.getData(from: "users", loadData(result:))
    }
}

// MARK: - SearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchText = selfView.searchBar.text ?? ""
        selfView.setSearchErrorView(error: model.filteredUser.isEmpty)
        selfView.userTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        selfView.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        selfView.searchBar.searchTextField.leftView = UIImageView(image: R.Images.SearchBar.leftImageNormal)
        selfView.searchBar.showsCancelButton = false
        selfView.searchBar.showsBookmarkButton = true
        selfView.searchBar.text = nil
        selfView.searchBar.endEditing(true)
        model.searchText = ""
        selfView.setSearchErrorView(error: false)
        selfView.userTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        present(sortViewController, animated: true)
    }
}

// MARK: - Sort Delegate

extension MainViewController: SortDelegate {
    
    func sort(model: SortModel) {
        switch model {
        case .alphabet:
            self.model.users.sort(by: { $0.firstName < $1.firstName })
        case .birhDate:
            self.model.userSortByDate()
        }
        
        selfView.searchBar.setImage(R.Images.SearchBar.rightImageSelected, for: .bookmark, state: .normal)
        selfView.userTableView.reloadData()
    }
    
    func showBirthday(shouldShow: Bool) {
        self.shouldShowBirthday = shouldShow
    }
}

// MARK: - CollectionView Delegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if model.selectedDepartment == tabs[indexPath.item] {
            model.selectedDepartment = nil
        } else {
            model.selectedDepartment = tabs[indexPath.item]
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        selfView.userTableView.reloadData()
        updateDepartmentSelection()
    }
}

// MARK: - CollectionView DataSource

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

// MARK: - CollectionView Delegate FlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = tabs[indexPath.item].title
        label.sizeToFit()
        
        return CGSize(width: label.frame.width, height: selfView.topTabsCollectionView.frame.height)
    }
}

// MARK: - TableView Delegate

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

// MARK: - TableView DataSource

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
        return self.shouldShowBirthday ? .two : .one
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
    
    func setScreenSettings() {
        setDelegate()
        setDataSource()
        setNavigationItem()
        setTopTabs()
        setTableView()
        setTargets()
        setViewDependingOnConnection()
    }
    
    func setDelegate() {
        sortViewController.delegate = self
        selfView.searchBar.delegate = self
        selfView.topTabsCollectionView.delegate = self
        selfView.userTableView.delegate = self
    }
    
    func setDataSource() {
        selfView.topTabsCollectionView.dataSource = self
        selfView.userTableView.dataSource = self
    }
    
    func setTargets() {
        selfView.internalErrorView.tryAgainButton.addTarget(self, action: #selector(checkConnection), for: .touchUpInside)
        selfView.searchBar.searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        selfView.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func setNavigationItem() {
        navigationItem.titleView = selfView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTopTabs() {
        selfView.topTabsCollectionView.showsHorizontalScrollIndicator = false
        selfView.topTabsCollectionView.register(
            TopTabsCollectionViewCell.self,
            forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier
        )
    }
    
    func setTableView() {
        selfView.userTableView.separatorColor = .clear
        selfView.userTableView.register(UserTableViewCell.self,
                                        forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func setViewDependingOnConnection() {
        if NetworkMonitor.shared.isConnected {
            selfView.setErrorView(error: false)
        } else {
            selfView.setErrorView(error: true)
        }
        
        NetworkMonitor.shared.stopMonitoring()
    }
    
    func updateDepartmentSelection() {
        selfView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == model.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
    
    func loadData(result: Result<UserModel, Error>) {
        switch result {
        case let .success(responseData):
            self.model.users = responseData.items
            self.selfView.setErrorView(error: false)
            self.selfView.userTableView.reloadData()
        case .failure(_:):
            PresentNetworkError().presentError()
        }
    }
    
    func pullRefresh(result: Result<UserModel, Error>) {
        loadData(result: result)
        self.selfView.refreshControl.endRefreshing()
    }
}

// MARK: - Actions

@objc
private extension MainViewController {
    
    func textChanged(_ sender: UITextField) {
        let image = sender.text?.count == .zero ? R.Images.SearchBar.leftImageNormal :
        R.Images.SearchBar.leftImageSelected
        sender.leftView = UIImageView(image: image)
    }
    
    func didPullToRefresh(_ sender: UIRefreshControl) {
        shouldShowBirthday = false
        networkTask.getData(from: "users", pullRefresh(result:))
    }
    
    func checkConnection(_ sender: UIButton) {
        networkTask.getData(from: "users", loadData(result:))
    }
}

// MARK: - Constants

private enum Constants {
    static let skeletonCellCount: Int = 15
    static let rowCellHeight: CGFloat = 84
    static let headerViewHeight: CGFloat = 68
}
