import PromiseKit
@testable import Core
@testable import RandomUserApp

class MockFailUserRepository: UserRepositoryProtocol {
    func search(by term: String) -> Promise<[User]> {
        return Promise.init(error: AppError.undefined)
    }
    
    func deleteUser(_ user: User) -> Promise<Void> {
        return Promise.init(error: AppError.undefined)
    }
    
    
     func loadUsers() -> Promise<[User]> {
        return Promise.init(error: AppError.undefined)
    }
    
    func fetchUsers() -> Promise<Core.Result> {
        return Promise.init(error: AppError.undefined)
    }
    
    func save(_ users: [UserDTO]) -> Promise<[User]> {
        return Promise.init(error: AppError.undefined)
    }
}
