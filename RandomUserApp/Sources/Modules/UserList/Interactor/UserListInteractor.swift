import UIKit

class UserListInteractor: UserListInteractorProtocol {
        
    weak var presenter: UserListInteractorOutputProtocol?
    var repository: UserRepositoryProtocol = UserRepository()
    
    func loadUsers() {
        let users = repository.loadUsers()
        presenter?.founded(users)
    }
}
