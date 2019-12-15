import UIKit
import Core

class UserListInteractor {
    private var blacklist = Set<UUID>()
    weak var presenter: UserListInteractorOutputProtocol?
    var repository: UserRepositoryProtocol = ServiceLocator.inject()
    
    private func isBlackListed(_ user: User) -> Bool {
        guard let userId = user.userID else { return false }
        return !self.blacklist.contains(userId)
    }
}

// MARK: UserListInteractorProtocol
extension UserListInteractor: UserListInteractorProtocol {
    
    func fetchUsers() {
        repository.fetchUsers().then {
            self.repository.save(Array(Set($0.results)))
        }.filterValues(isBlackListed).done { users in
            self.presenter?.founded(users)
            print(users.count)
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
        guard let userID = user.userID else { return }
        repository.deleteUser(user).done {
            self.blacklist.insert(userID)
        }.catch { error in
            // TODO: handle error
        }
    }
    
    func findUsers(by term: String) {
        repository.search(by: term).done { users in
            self.presenter?.founded(users)
        }.catch { error in
            // TODO: handle error
        }
    }
}
