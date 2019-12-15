import PromiseKit

public protocol UserRepositoryProtocol {
    func fetchUsers() -> Promise<Result>
}

public class UserRepository: UserRepositoryProtocol {
    public init() {}
    
    var userDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return jsonDecoder
    }
    
    public func fetchUsers() -> Promise<Result> {
        return APIClient.request(UserAPIRouter.users, userDecoder)
    }
}
