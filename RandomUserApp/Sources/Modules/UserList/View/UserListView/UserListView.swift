import UIKit
import RxSwift

enum UserListViewEvent {
    case show(_ users: [UpcomingDisplayUser])
    case failure(_ error: Error)
}

class UserListView: UIViewController {

    private var disposeBag = DisposeBag()
    var observer = PublishSubject<UserListViewEvent>()
    var presenter: PublishSubject<UserListPresenterEvent>?
    
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    private var prefetchCount = 3
    private var users = [UpcomingDisplayUser]()

	override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        customizeUI()
        presenter?.onNext(.getUsers)
    }
    
    private func customizeUI() -> Void {
        tableView.tableFooterView = UIView()
        tableView.register(UserTableViewCell.self)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
     }
    
    private func subscribe() {
        observer.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: disposeBag)
    }
    
    private func handle(_ event: UserListViewEvent) {
        switch event {
        case let .show(users):
            self.show(users)
        case let .failure(error):
            print(error)
        }
    }
    
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
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserTableViewCell
        cell.configure(users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        presenter?.onNext(.delete(index: indexPath.row))        
        users.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// MARK: UITableViewDelegate
extension UserListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.resignFirstResponder()
        presenter?.onNext(.didSelect(index: indexPath.row))
    }
}

// MARK: UITableViewDataSourcePrefetching
extension UserListView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: {$0.row > users.count - prefetchCount}) {
            presenter?.onNext(.getUsers)
        }
    }
}

// MARK: UISearchBarDelegate
extension UserListView: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.onNext(.find(term: ""))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.onNext(.find(term: searchText))
    }
}
