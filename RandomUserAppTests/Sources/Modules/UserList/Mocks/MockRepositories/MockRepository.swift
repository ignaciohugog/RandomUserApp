import Foundation
import PromiseKit

@testable import Core
@testable import RandomUserApp

class MockUserRepository: UserRepositoryProtocol {
    
    let numberOfStoredUsers: Int
    let numberOfUsersForResponse: Int
    
      func loadUsers() -> Promise<[User]> {
          var users = [User]()
          Array(0..<numberOfStoredUsers).forEach {
              users.append(MockUser(name: "\($0)"))
          }
                  
          return Promise.value(users)
      }
      
      func fetchUsers() -> Promise<Core.Result> {
          var users = [UserDTO]()
          Array(0..<numberOfUsersForResponse).forEach {
              users.append(UserDTO(name: "\($0)"))
          }
          
          return Promise.value(Core.Result(results: users))
      }
    
      func save(_ users: [UserDTO]) -> Promise<[User]> {
          return Promise.value(users.map{MockUser(dto: $0)})
      }
    
    init(_ numberOfstoredUsers: Int,
         _ numberOfUsersForResponse: Int = 0) {
        self.numberOfStoredUsers = numberOfstoredUsers
        self.numberOfUsersForResponse = numberOfUsersForResponse
    }
    
    
}
