import Foundation
import Core

class IdleState: UserListInteractorOutputProtocol, UserListPresenterProtocol {
            
    var users = [User]()
    var presenter: UserListPresenter?
    
    init(presenter: UserListPresenter?) {
        self.presenter = presenter
    }
    
    func didSelect(at index: Int) {
        guard let router = presenter?.router else { return }
        router.present(users[index])
    }
    
    func delete(at index: Int) {
        guard let interactor = presenter?.interactor else { return }
        let user = users.remove(at: index)
        interactor.delete(user)
    }
    
    func show() {
        let users = self.users.map{ UserListPresenter.prepareForView($0) }
        presenter?.view?.show(users)
    }
    
    func getUsers() {}
    func founded(_ users: [User]) {}
    func findUsers(by term: String) {}
}

