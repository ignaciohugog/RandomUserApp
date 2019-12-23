import Foundation
import RxSwift
@testable import Core
@testable import RandomUserApp

class MockUserRepository: UserRepositoryProtocol {
        
    let numberOfStoredUsers: Int
    let numberOfUsersForResponse: Int
    
    init(_ numberOfstoredUsers: Int,
         _ numberOfUsersForResponse: Int = 0) {
        self.numberOfStoredUsers = numberOfstoredUsers
        self.numberOfUsersForResponse = numberOfUsersForResponse
    }
    
    func loadUsers() -> Single<[User]> {
        var users = [User]()
        Array(0..<numberOfStoredUsers).forEach {
            users.append(MockUser(name: "\($0)"))
        }
        
        return Single.create {
            $0(.success(users))
            return Disposables.create {}
        }
    }
      
    func fetchUsers() -> Single<Core.Result> {
        var users = [UserDTO]()
        Array(0..<numberOfUsersForResponse).forEach {
            users.append(UserDTO(name: "\($0)"))
        }
        
        return Single.create {
            $0(.success(Core.Result(results: users)))
            return Disposables.create {}
        }
    }
    
    func save(_ users: [UserDTO]) -> Single<[User]> {
        let users = users.map{MockUser(dto: $0)}
        return Single.create {
            $0(.success(users))
            return Disposables.create {}
        }
    }
    
    func deleteUser(_ user: User) -> Completable {
        return Completable.create {
            $0(.completed)
            return Disposables.create {}
        }
    }
    
    func search(by term: String) -> Single<[User]> {
        return Single.create {
            $0(.success([User]()))
            return Disposables.create {}
        }
    }
}
