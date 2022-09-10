import UIKit

class MainViewController: BaseViewController<MainRootView> {
    
    let sortVC = SortViewController()
    var shouldShowBirthday: Bool = false
    
    private var searchText: String = ""
    private let tabs = Department.allCases
    private let departmentAll = Department.all
    private var selectedDepartment: Department?
    private var users: [Item] = []
    private let apiProvider = ApiProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupSearchBar()
        mainView.errorView.tryAgainButton.addTarget(self, action: #selector(checkConnection(_:)), for: .touchUpInside)
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        mainView.topTabsCollectionView.register(TopTabsCollectionViewCell.self,
                                                forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        mainView.topTabsCollectionView.showsHorizontalScrollIndicator = false
        setupTableView()
        apiProvider.getData(UserModel.self, from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.users = responseData.items
                self.mainView.setMainView()
                self.mainView.userTableView.reloadData()
            case .failure(_:):
                self.mainView.setErrorView()
            }
        }
        mainView.searchBar.delegate = self
        navigationItem.titleView = mainView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    private var filteredUser: [Item] {
        return users
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil || selectedDepartment == departmentAll
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty
            })
    }
    
    var thisYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) > 0
        }
    }
    
    var nextYearBirthdayUser: [Item] {
        return filteredUser.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) < 0
        }
    }
    
    var userModelForSections: [[Item]] {
        return [thisYearBirthdayUser, nextYearBirthdayUser]
    }
    
    func calculateDayDifference(birthdayDate: Date?) -> Int {
        guard let date = birthdayDate else { return 0}
        let calendar = Calendar.current
        let dateCurrent = Date()
        let dateComponentsNow = calendar.dateComponents([.day, .month, .year], from: dateCurrent)
        let birthdayDateComponents = calendar.dateComponents([.day, .month], from: date)
        var bufferDateComponents = DateComponents()
        bufferDateComponents.year = dateComponentsNow.year
        bufferDateComponents.month = birthdayDateComponents.month
        bufferDateComponents.day = birthdayDateComponents.day
        guard let bufferDate = calendar.date(from: bufferDateComponents) else { return 0 }
        guard let dayDifference = calendar.dateComponents([.day],
                                                          from: dateCurrent, to: bufferDate).day else { return 0 }
        return dayDifference
    }
    
    func updateSearchResults(_ searchBar: UISearchBar) {
        searchText = mainView.searchBar.text ?? ""
        if searchText.isEmpty {
            mainView.setNotFoundView()
        } else {
            mainView.setIsFoundView()
        }
            mainView.userTableView.reloadData()
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        refresh.tintColor = .lightGray
        return refresh
    }()
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        self.mainView.setMainView()
        apiProvider.getData(UserModel.self,
                                 from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.users = responseData.items
                self.mainView.setMainView()
                self.shouldShowBirthday = false
                self.mainView.userTableView.reloadData()
                self.refreshControl.endRefreshing()
            case let .failure(error):
                self.refreshControl.endRefreshing()
                self.mainView.setErrorView()
                print(error)
            }
        }
    }
    
    @objc private func checkConnection(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 0.3)
        self.mainView.setMainView()
        apiProvider.getData(UserModel.self,
                                 from: "/kode-education/trainee-test/25143926/users", self.loadData(result:))
    }
    
    private func loadData(result: Result<UserModel, Error>) {
        switch result {
        case let .success(responseData):
            self.users = responseData.items
            self.mainView.setMainView()
            self.mainView.userTableView.reloadData()
        case .failure(_:):
            self.mainView.setErrorView()
        }
    }
    
    private func formatDate (date: Date?) -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.setLocalizedDateFormatFromTemplate("dd MMM")

        if let date = date {
            var date = formatter.string(from: date)
            if date.count == 7 {
                date.removeLast()
            }
            if date.count == 8 {
                date.removeLast(2)
            }
            return date
        }
        return "Дата не была получена"
    }
    
    private func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == self.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
    
    private func updateSortButtonSelection() {
        if shouldShowBirthday {
            mainView.searchBar.setImage(UIImage(named: "list-ui-alt"), for: .bookmark, state: .normal)
        } else {
            mainView.searchBar.setImage(UIImage(named: "list-ui-alt_selected"), for: .bookmark, state: .normal)
        }
    }
}

// MARK: extension for UITableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if users.isEmpty {
            return 15
        } else {
            if self.shouldShowBirthday {
                return section == 0 ? thisYearBirthdayUser.count : nextYearBirthdayUser.count
            } else {
                return filteredUser.count
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.shouldShowBirthday ?  2 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            return HeaderSectionView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier)
                as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        
        if !users.isEmpty {
            if shouldShowBirthday {
                let sortedUser = userModelForSections[indexPath.section][indexPath.row]
                cell.setData(firstName: sortedUser.firstName,
                             lastName: sortedUser.lastName,
                             tag: sortedUser.userTag,
                             department: sortedUser.department,
                             dateBirth: formatDate(date: sortedUser.birthdayDate))
            } else {
                let user = filteredUser[indexPath.row]
                
                cell.setData(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    tag: user.userTag,
                    department: user.department,
                    dateBirth: formatDate(date: user.birthdayDate))
            }
            
            cell.setBirthdayLabelVisibility(shouldShowBirthday: self.shouldShowBirthday)
        } else {
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = ProfileViewController()
        viewController.item = filteredUser[indexPath.item]
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: extension for UICollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabsCollectionViewCell.identifier,
                                                            for: indexPath) as? TopTabsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setModel(tabs[indexPath.item])
        cell.setCellSelected(tabs[indexPath.item] == selectedDepartment)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedDepartment == tabs[indexPath.item] {
            selectedDepartment = nil
        } else {
            selectedDepartment = tabs[indexPath.item]
        }
        
        mainView.userTableView.reloadData()
        updateDepartmentSelection()
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = mainView.searchBar.text ?? ""
        
        if self.searchText.isEmpty {
            mainView.setNotFoundView()
        } else {
            mainView.setIsFoundView()
        }
        mainView.userTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = false
        mainView.searchBar.showsBookmarkButton = true
        mainView.searchBar.text = nil
        mainView.searchBar.endEditing(true)
        searchText = ""
        mainView.setIsFoundView()
        mainView.userTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        present(sortVC, animated: true, completion: nil)
    }
}

// MARK: - SortViewDelegate

extension MainViewController: SortViewDelegate {
    
    func sortByAlphabet() {
        users.sort(by: { $0.firstName < $1.firstName })
        updateSortButtonSelection()
        mainView.userTableView.reloadData()
    }
    
    func sortByBirthday() {
        users.sort { date1, date2 in
            guard let date1 = date1.birthdayDate else { return false }
            guard let date2 = date2.birthdayDate else { return false }
            var dayDifference1 = calculateDayDifference(birthdayDate: date1)
            var dayDifference2 = calculateDayDifference(birthdayDate: date2)
            
            if dayDifference1 < 0 {
                dayDifference1 += 365
            }
            if dayDifference2 < 0 {
                dayDifference2 += 365
            }
            
            return dayDifference1 < dayDifference2
        }
        mainView.userTableView.reloadData()
        updateSortButtonSelection()
    }
    
    func showBirthday(shouldShow: Bool) {
        self.shouldShowBirthday = shouldShow
        mainView.userTableView.reloadData()
    }
}
