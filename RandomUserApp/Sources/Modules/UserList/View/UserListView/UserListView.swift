import UIKit

class UserListView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var prefetchCount = 3
    private var users = [UpcomingDisplayUser]()
    var presenter: UserListPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        presenter?.getUsers()
    }
    
    private func customizeUI() -> Void {
         tableView.register(UserTableViewCell.self)
     }
}

// MARK: PersonListViewProtocol
extension UserListView: UserListViewProtocol {
    func show(_ users: [UpcomingDisplayUser]) -> Void {
        self.users = users
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension UserListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserTableViewCell
        cell.configure(users[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension UserListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.resignFirstResponder()
        presenter?.didSelect(at: indexPath.row)
    }
}

// MARK: UITableViewDataSourcePrefetching
extension UserListView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: {$0.row > users.count - prefetchCount}) {
            presenter?.getUsers()
        }
    }
}
