import UIKit

final class MainViewController: BaseViewController<MainRootView> {
    
    private lazy var shouldShowBirthday: Bool = false
    private lazy var sortVC = SortViewController()
    private lazy var model = MainModel()
    private lazy var tabs = Department.allCases
    private lazy var apiProvider = ApiProvider()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        refresh.tintColor = .lightGray
        return refresh
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortVC.delegate = self
        setupNavigationItem()
        setupTopTabs()
        setupTableView()
        setupTargets()
        
        apiProvider.getData(UserModel.self, from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.model.users = responseData.items
                self.mainView.setMainView()
                self.mainView.userTableView.reloadData()
            case .failure(_:):
                self.mainView.setErrorView()
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchText = mainView.searchBar.text ?? ""
        
        if model.filteredUser.isEmpty {
            mainView.setSearchErrorView()
        } else {
            mainView.setTableView()
        }
        mainView.userTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.searchTextField.leftView = UIImageView(image: UIImage(named: "Vector"))
        mainView.searchBar.showsCancelButton = false
        mainView.searchBar.showsBookmarkButton = true
        mainView.searchBar.text = nil
        mainView.searchBar.endEditing(true)
        model.searchText = ""
        mainView.setTableView()
        mainView.userTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        present(sortVC, animated: true, completion: nil)
    }
}

// MARK: - SortDelegate

extension MainViewController: SortDelegate {
    
    func sortByAlphabet() {
        model.users.sort(by: { $0.firstName < $1.firstName })
        mainView.searchBar.setImage(UIImage(named: "list-ui-alt_selected"), for: .bookmark, state: .normal)
        mainView.userTableView.reloadData()
    }
    
    func sortByBirthday() {
        model.userSortByDate()
        mainView.searchBar.setImage(UIImage(named: "list-ui-alt_selected"), for: .bookmark, state: .normal)
        mainView.userTableView.reloadData()
    }
    
    func showBirthday(shouldShow: Bool) {
        self.shouldShowBirthday = shouldShow
        mainView.userTableView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
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

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if model.selectedDepartment == tabs[indexPath.item] {
            model.selectedDepartment = nil
        } else {
            model.selectedDepartment = tabs[indexPath.item]
        }
        
        mainView.userTableView.reloadData()
        updateDepartmentSelection()
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ProfileViewController()
        viewController.item = model.filteredUser[indexPath.item]
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section != 0 ? HeaderSectionView() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != 0 ? 68 : 0
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.users.isEmpty {
            return 15
        } else {
            if self.shouldShowBirthday {
                return section == 0 ? model.thisYearBirthdayUser.count : model.nextYearBirthdayUser.count
            } else {
                return model.filteredUser.count
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.shouldShowBirthday ?  2 : 1
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
            cell.setViewWithData()
            
        } else {
            cell.setSkeletonView()
        }
        return cell
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func setupTargets() {
        mainView.errorView.tryAgainButton.addTarget(self, action: #selector(checkConnection), for: .touchUpInside)
        mainView.searchBar.searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    func setupNavigationItem() {
        mainView.searchBar.delegate = self
        navigationItem.titleView = mainView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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
        mainView.userTableView.refreshControl = refreshControl
        mainView.userTableView.separatorColor = .clear
        mainView.userTableView.delegate = self
        mainView.userTableView.dataSource = self
        mainView.userTableView.register(UserTableViewCell.self,
                                            forCellReuseIdentifier: UserTableViewCell.identifier)
        mainView.userTableView.rowHeight = 90
    }
    
    func loadData(result: Result<UserModel, Error>) {
        switch result {
        case let .success(responseData):
            self.model.users = responseData.items
            self.mainView.setMainView()
            self.mainView.userTableView.reloadData()
        case .failure(_:):
            self.mainView.setErrorView()
        }
    }
    
    func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == model.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
}

// MARK: - Actions

@objc
private extension MainViewController {
    
    func textChanged(_ sender: UITextField) {
        let image = sender.text?.count == .zero ? UIImage(named: "Vector") : UIImage(named: "vector_editing")
        sender.leftView = UIImageView.init(image: image)
    }
    
    func didPullToRefresh(_ sender: UIRefreshControl) {
        self.mainView.setMainView()
        shouldShowBirthday = false
        apiProvider.getData(UserModel.self,
                                 from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.model.users = responseData.items
                self.mainView.userTableView.reloadData()
                self.refreshControl.endRefreshing()
            case let .failure(error):
                self.refreshControl.endRefreshing()
                self.mainView.setErrorView()
                print(error)
            }
        }
    }
    
    func checkConnection(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 0.3)
        self.mainView.setMainView()
        apiProvider.getData(UserModel.self,
                                 from: "/kode-education/trainee-test/25143926/users", self.loadData(result:))
    }
}
