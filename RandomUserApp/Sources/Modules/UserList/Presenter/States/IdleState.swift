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
    
    func show() {
        let users = self.users.map{ UserListPresenter.prepareForView($0) }
        presenter?.view?.show(users)
    }
    
    func getUsers() {}
    func founded(_ users: [User]) {}
}

