import PromiseKit
@testable import Core
@testable import RandomUserApp

class MockDuplicateUserRepository: MockUserRepository {
    override func fetchUsers() -> Promise<Core.Result> {
        let users = Array(repeating: UserDTO(name: ""), count: numberOfUsersForResponse)
        return Promise.value(Core.Result(results: users))
    }
}
