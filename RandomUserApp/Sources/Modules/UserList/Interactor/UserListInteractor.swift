import Core
import RxSwift

enum UserListInteractorEvent {
    case fetchUsers
    case loadUsers
    case delete(_ user: User)
    case findUsers(term: String)
}

class UserListInteractor {
    private var blacklist = Set<UUID>()
    private var disposeBag = DisposeBag()
    let input = PublishSubject<UserListInteractorEvent>()
    var output: PublishSubject<UserListInteractorOutputEvent>?
    
    var repository: UserRepositoryProtocol = ServiceLocator.inject()
    
    private func isBlackListed(_ user: User) -> Bool {
        guard let userId = user.userID else { return false }
        return !self.blacklist.contains(userId)
    }
    
    init() {
        input.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: disposeBag)
    }
    
    private func handle(_ event: UserListInteractorEvent) {
        switch event {
        case .fetchUsers:
            self.fetchUsers()
        case .loadUsers:
            self.loadUsers()
        case let .delete(user):
            self.delete(user)
        case let .findUsers(term):
            self.findUsers(by: term)
        }
    }
    
    // TODO: BlackListed
    private func fetchUsers() -> Void {
        repository.fetchUsers().map {
            Array(Set($0.results))
        }.flatMap {
            self.repository.save($0)
        }.subscribe(onSuccess: { users in
            self.output?.onNext(.founded(users))
        }) { error in
            self.output?.onNext(.failure(error))
        }.disposed(by: disposeBag)
    }
    
    private func loadUsers() -> Void {
        repository.loadUsers().subscribe(onSuccess: { users in
            users.isEmpty ? self.fetchUsers() : self.output?.onNext(.founded(users))
        }) { error in
            self.output?.onNext(.failure(error))
        }.disposed(by: disposeBag)
    }
    
     private func delete(_ user: User) -> Void {
        guard let userID = user.userID else { return }
                
        repository.deleteUser(user).subscribe(onCompleted: {
            self.blacklist.insert(userID)
        }) { error in
            self.output?.onNext(.failure(error))
        }.disposed(by: disposeBag)
    }
    
    private func findUsers(by term: String) -> Void {
        
        repository.search(by: term).subscribe(onSuccess: { users in
            self.output?.onNext(.founded(users))
        }) { error in
            self.output?.onNext(.failure(error))
        }.disposed(by: disposeBag)
    }
}
