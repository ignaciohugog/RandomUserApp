import Foundation
import Core

class IdleState {
            
    var users = [User]()
    var presenter: UserListPresenter?
    
    init(presenter: UserListPresenter?) {
        self.presenter = presenter
    }
    
    func didSelect(at index: Int) -> Void{
        guard let router = presenter?.outputRouter else { return }
        router.onNext(.present(user: users[index]))        
    }
    
    func delete(at index: Int) -> Void {
        guard let interactor = presenter?.outputInteractor else { return }
        let user = users.remove(at: index)
        interactor.onNext(.delete(user))
    }
    
    func show() -> Void {
        guard let presenter = presenter else { return  }
        let users = self.users.map{ presenter.prepareForView($0) }
        presenter.outputView?.onNext(.show(users))
    }
    
    func failure(_ error: Error) -> Void {
        presenter?.inputInteractor.onNext(.failure(error))
    }
    
    func getUsers() -> Void {}
    func founded(_ users: [User]) -> Void {}
    func findUsers(by term: String) -> Void {}
}

