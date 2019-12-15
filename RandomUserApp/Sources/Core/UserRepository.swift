import Foundation

public protocol UserRepositoryProtocol {
    func loadUsers() -> [User]
}

public class UserRepository: UserRepositoryProtocol {
    public func loadUsers() -> [User] {
        return [MockUser()]
    }        
}
