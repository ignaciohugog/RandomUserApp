import Core
import RxSwift

enum UserListPresenterEvent {
    case getUsers
    case find(term: String)
    case delete(index: Int)
    case didSelect(index: Int)
}

enum UserListInteractorOutputEvent {
    case founded(_ users: [User])
    case failure(_ error: Error)
}

class UserListPresenter {

    private var disposeBag = DisposeBag()
    var inputPresenter = PublishSubject<UserListPresenterEvent>()
    var inputInteractor = PublishSubject<UserListInteractorOutputEvent>()
    
    var outputView: PublishSubject<UserListViewEvent>?
    var outputRouter: PublishSubject<UserListRouterEvent>?
    var outputInteractor: PublishSubject<UserListInteractorEvent>?
        
    var state: IdleState?
    var idleState: IdleState?
    var searchState: SearchState?
    var fetchState: FetchState?
    
    private var active: Bool {
        return state is FetchState || state is SearchState
    }
    
    init() {
        inputPresenter.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: disposeBag)
        
        inputInteractor.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: disposeBag)
    }
    
    private func handle( _ event: UserListInteractorOutputEvent) {
        switch event {
        case let .founded(users):
            self.state?.founded(users)
        case let .failure(error):
            state = idleState
            self.outputView?.onNext(.failure(error))
        }
    }
    
    private func handle(_ event: UserListPresenterEvent) {
        switch event {
        case .getUsers:
            self.getUsers()
        case let .find(term):
            self.findUsers(by: term)
        case let .delete(index):
            self.delete(at: index)
        case let .didSelect(index):
            self.didSelect(at: index)
        }
    }
    
    private func didSelect(at index: Int) -> Void {
        state?.didSelect(at: index)
    }
    
    private func delete(at index: Int) -> Void {
        state?.delete(at: index)
    }
    
    private func findUsers(by term: String) -> Void {
        state = searchState
        state?.findUsers(by: term)
    }
    
    private func getUsers() -> Void {
        guard active else {
            state = fetchState
            state?.getUsers()
            return
        }
    }
}

extension UserListPresenter {
    func prepareForView(_ user: User) -> UpcomingDisplayUser {
        return UpcomingDisplayUser(name: [user.name, user.surname].joined(separator: " "),
                                   email: user.email,
                                   phone: user.phone,
                                   image: user.picture)
    }
}
