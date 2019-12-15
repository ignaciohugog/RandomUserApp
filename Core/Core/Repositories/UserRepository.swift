import Foundation

public protocol UserRepositoryProtocol {
    func loadUsers() -> [User]
}

public class UserRepository: UserRepositoryProtocol {
    public init() {}
    public func loadUsers() -> [User] {
        
        return [User]()
    }        
}
