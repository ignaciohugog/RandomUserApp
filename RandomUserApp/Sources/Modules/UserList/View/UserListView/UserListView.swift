import UIKit

class UserListView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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

// MARK: TableView methods
extension UserListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserTableViewCell
        cell.configure(users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.resignFirstResponder()
        presenter?.didSelect(at: indexPath.row)
    }
}
