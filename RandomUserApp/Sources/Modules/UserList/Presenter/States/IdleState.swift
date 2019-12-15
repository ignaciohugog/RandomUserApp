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
        guard let presenter = presenter else { return  }
        let users = self.users.map{ presenter.prepareForView($0) }
        presenter.view?.show(users)
    }
    
    func getUsers() {}
    func founded(_ users: [User]) {}
    func findUsers(by term: String) {}
}

