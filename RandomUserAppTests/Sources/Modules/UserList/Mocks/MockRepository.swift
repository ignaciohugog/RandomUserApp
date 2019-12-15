import Foundation

@testable import Core
@testable import RandomUserApp

class MockUserRepository: UserRepositoryProtocol {
    let numberOfStoredUsers: Int
    let numberOfUsersForResponse: Int
    
     func loadUsers() -> [User] {                
        return Array(repeating: MockUser(), count: numberOfStoredUsers)
    }
    
    init(_ numberOfstoredUsers: Int,
         _ numberOfUsersForResponse: Int = 0) {
        self.numberOfStoredUsers = numberOfstoredUsers
        self.numberOfUsersForResponse = numberOfUsersForResponse
    }
    
    
}
