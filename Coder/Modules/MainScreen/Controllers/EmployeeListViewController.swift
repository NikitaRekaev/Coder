import UIKit

class EmployeeListViewController: BaseViewController<EmployeeListRootView> {
    var shouldShowBirthday: Bool = false
    private var searchText: String = ""
    private let tabs = DepartmentModel.allCases
    private let departmentAll = DepartmentModel.all
    private var selectedDepartment: DepartmentModel?
    private var employee: [EmployeeModel] = []
    private var filteredEmployee: [EmployeeModel] {
        return employee
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil || selectedDepartment == departmentAll
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty
            })
    }

    private let employeeProvider = ApiProvider()
       override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupSearchBar()
        mainView.errorView.tryAgainButton.addTarget(self, action: #selector(checkConnection(_:)), for: .touchUpInside)
        mainView.employeeTableView.refreshControl = refreshControl
        mainView.employeeTableView.separatorColor = .clear
        mainView.employeeTableView.delegate = self
        mainView.employeeTableView.dataSource = self
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        mainView.employeeTableView.register(EmployeeTableViewCell.self,
                                            forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        mainView.employeeTableView.rowHeight = 90
        mainView.topTabsCollectionView.register(TopTabsCollectionViewCell.self,
                                                forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        mainView.topTabsCollectionView.showsHorizontalScrollIndicator = false
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.setMainView()
                self.mainView.employeeTableView.reloadData()
            case .failure(_:):
                self.mainView.setErrorView()
            }
        }
        mainView.searchBar.delegate = self
        navigationItem.titleView = mainView.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func updateSearchResults(_ searchBar: UISearchBar) {
        searchText = mainView.searchBar.text ?? ""
        if searchText.isEmpty {
            mainView.setNotFoundView()
        } else {
            mainView.setIsFoundView()
        }
            mainView.employeeTableView.reloadData()
    }
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        refresh.tintColor = .lightGray
        return refresh
    }()
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        self.mainView.setMainView()
        employeeProvider.getData(EmployeeList.self,
                                 from: "/kode-education/trainee-test/25143926/users") { result in
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.setMainView()
                self.shouldShowBirthday = false
                self.mainView.employeeTableView.reloadData()
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
        employeeProvider.getData(EmployeeList.self,
                                 from: "/kode-education/trainee-test/25143926/users", self.loadData(result:))
    }
    private func loadData(result: Result<EmployeeList, Error>) {
        switch result {
        case let .success(responseData):
            self.employee = responseData.items
            self.mainView.setMainView()
            self.mainView.employeeTableView.reloadData()
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
}

// MARK: extension for UITableView

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employee.isEmpty {
            return 15
        } else {
            return filteredEmployee.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeTableViewCell.identifier
        ) as? EmployeeTableViewCell else {
            return UITableViewCell()
        }
                if !employee.isEmpty {
                let employee = filteredEmployee[indexPath.row]
                    cell.setData(
                        firstName: employee.firstName,
                        lastName: employee.lastName,
                        tag: employee.userTag,
                        department: employee.department,
                        dateBirth: formatDate(date: employee.birthdayDate))
                    cell.setViewWithData()
                } else {
                    cell.setLoadingView()
                }
                return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewController = DetailsViewController()
        viewController.employee = filteredEmployee[indexPath.item]
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: extension for UICollectionView

extension EmployeeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        mainView.employeeTableView.reloadData()
        updateDepartmentSelection()
    }

}

// MARK: - UISearchBarDelegate

extension EmployeeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = mainView.searchBar.text ?? ""
        if self.searchText.isEmpty {
            return mainView.setNotFoundView()
        } else {
            mainView.setIsFoundView()
        }
            mainView.employeeTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.showsCancelButton = false
        mainView.searchBar.showsBookmarkButton = true
        mainView.searchBar.text = nil
        mainView.searchBar.endEditing(true)
        mainView.employeeTableView.isHidden = false
        searchText = ""
        mainView.employeeTableView.reloadData()
    }
}
