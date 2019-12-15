import UIKit
import Core

class UserListInteractor {
    
    weak var presenter: UserListInteractorOutputProtocol?
    var repository: UserRepositoryProtocol = UserRepository(store: ServiceLocator.inject())
}

// MARK: UserListInteractorProtocol
extension UserListInteractor: UserListInteractorProtocol {
    
    func fetchUsers() {
        repository.fetchUsers().then {
            self.repository.save(Array(Set($0.results)))
        }.done { users in
            self.presenter?.founded(users)
        }.catch { error in
            // TODO: handle error
        }
    }
    
    func loadUsers() {
        repository.loadUsers().done { users in
            users.isEmpty ? self.fetchUsers() : self.presenter?.founded(users)
        }.catch { error in
            // TODO: handle error
        }
    }
    
    func delete(_ user: User) {
        let _ = repository.deleteUser(user).done {}
    }
}
