import PromiseKit
import RxSwift

public protocol UserRepositoryProtocol {
    func loadUsers() -> Single<[User]>
    func fetchUsers() -> Single<Result>
    func deleteUser(_ user: User) -> Completable
    func save(_ users: [UserDTO]) -> Single<[User]>
    func search(by term: String) -> Single<[User]>
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
    public func loadUsers() -> Single<[User]> {
        return store.fetchUsers()
    }
    
    public func fetchUsers() -> Single<Result> {
        return APIClient.request(UserAPIRouter.users, userDecoder)
    }
    
    public func save(_ users: [UserDTO]) -> Single<[User]> {
        return store.saveUsers(dtos: users)
    }
    
    public func deleteUser(_ user: User) -> Completable {
        return store.deleteUser(user)
    }
    
    public func search(by term: String) -> Single<[User]> {
        return store.searchUsers(by: term)
    }
}
