import Foundation
import Core

//MARK: Router
protocol UserListRouterProtocol: class {

}

//MARK: Presenter
protocol UserListPresenterProtocol: class {
    func getUsers() -> Void
}

//MARK: Interactor
protocol UserListInteractorProtocol: class {
    var presenter: UserListInteractorOutputProtocol?  { get set }
    func loadUsers() -> Void
}

protocol UserListInteractorOutputProtocol: class {
    func founded(_ users: [User]) -> Void
}

//MARK: View
protocol UserListViewProtocol: class {
    var presenter: UserListPresenterProtocol?  { get set }
    func show(_ persons: [UpcomingDisplayUser]) -> Void
}

struct UpcomingDisplayUser {
    let name: String
    let email: String
    let phone: String
    let image: String
}
