import Foundation
import Core

//MARK: Router
protocol UserListRouterProtocol: class {
    func present(_ user: User) -> Void
}

//MARK: Presenter
protocol UserListPresenterProtocol: class {
    func getUsers() -> Void
    func delete(at index: Int) -> Void
    func didSelect(at index: Int) -> Void
}

//MARK: Interactor
protocol UserListInteractorProtocol: class {
    var presenter: UserListInteractorOutputProtocol?  { get set }
    func loadUsers() -> Void
    func fetchUsers() -> Void
    func delete(_ user: User) -> Void
}

protocol UserListInteractorOutputProtocol: class {
    func founded(_ users: [User]) -> Void
}

//MARK: View
protocol UserListViewProtocol: class {
    var presenter: UserListPresenterProtocol?  { get set }
    func show(_ persons: [UpcomingDisplayUser]) -> Void
}
