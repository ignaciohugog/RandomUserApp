import Foundation
import PromiseKit

@testable import Core
@testable import RandomUserApp

class MockUserRepository: UserRepositoryProtocol {
    
    let numberOfStoredUsers: Int
    let numberOfUsersForResponse: Int
    
    func fetchUsers() -> Promise<Core.Result> {
        return Promise.value(Core.Result(results: Array(repeating: UserDTO(name: ""), count: numberOfStoredUsers)))
    }
    
    init(_ numberOfstoredUsers: Int,
         _ numberOfUsersForResponse: Int = 0) {
        self.numberOfStoredUsers = numberOfstoredUsers
        self.numberOfUsersForResponse = numberOfUsersForResponse
    }
    
    
}
