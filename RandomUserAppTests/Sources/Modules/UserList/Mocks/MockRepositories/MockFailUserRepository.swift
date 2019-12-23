import RxSwift
@testable import Core
@testable import RandomUserApp

class MockFailUserRepository: UserRepositoryProtocol {
    func search(by term: String) -> Single<[User]> {
        return Single.create {
            $0(.error(AppError.undefined))
            return Disposables.create {}
        }
    }
    
    func deleteUser(_ user: User) -> Completable {
        return Completable.create {
            $0(.error(AppError.undefined))
            return Disposables.create {}
        }
    }
    
    
     func loadUsers() -> Single<[User]> {
        return Single.create {
            $0(.error(AppError.undefined))
            return Disposables.create {}
        }
    }
    
    func fetchUsers() -> Single<Core.Result> {
        return Single.create {
            $0(.error(AppError.undefined))
            return Disposables.create {}
        }
    }
    
    func save(_ users: [UserDTO]) -> Single<[User]> {
        return Single.create {
            $0(.error(AppError.undefined))
            return Disposables.create {}
        }
    }
}
