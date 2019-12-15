import PromiseKit

public protocol UserRepositoryProtocol {
    func loadUsers() -> Promise<[User]>
    func fetchUsers() -> Promise<Result>
    func deleteUser(_ user: User) -> Promise<Void>
    func save(_ users: [UserDTO]) -> Promise<[User]>
    func search(by term: String) -> Promise<[User]>
}

public class UserRepository {
    
    var store: CoreDataStore
    public init(store: CoreDataStore) {
        self.store = store
    }
    
    var userDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return jsonDecoder
    }
    
}

extension UserRepository: UserRepositoryProtocol {
    public func loadUsers() -> Promise<[User]> {
        return store.fetchUsers()
    }
    
    public func fetchUsers() -> Promise<Result> {
        return APIClient.request(UserAPIRouter.users, userDecoder)
    }
    
    public func save(_ users: [UserDTO]) -> Promise<[User]> {
        return store.saveUsers(dtos: users)
    }
    
    public func deleteUser(_ user: User) -> Promise<Void> {
        return store.deleteUser(user)
    }
    
    public func search(by term: String) -> Promise<[User]> {
        return store.searchUsers(by: term)
    }
}
