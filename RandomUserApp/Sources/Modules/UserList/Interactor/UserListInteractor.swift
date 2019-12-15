import UIKit
import Core

class UserListInteractor: UserListInteractorProtocol {
        
    weak var presenter: UserListInteractorOutputProtocol?
    var repository: UserRepositoryProtocol = UserRepository()
    
    func loadUsers() {
        repository.fetchUsers().done { result in
            let users = result.results.map{ MockUser(dto: $0)}
            self.presenter?.founded(users)
        }
    }
}
