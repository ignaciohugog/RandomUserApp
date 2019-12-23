import RxSwift
@testable import Core
@testable import RandomUserApp

class MockDuplicateUserRepository: MockUserRepository {
    override func fetchUsers() -> Single<Core.Result> {
        let users = Array(repeating: UserDTO(name: ""), count: numberOfUsersForResponse)
        
        return Single.create {
            $0(.success(Core.Result(results: users)))
            return Disposables.create {}
        }        
    }
}
