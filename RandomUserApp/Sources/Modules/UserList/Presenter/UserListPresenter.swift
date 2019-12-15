import Core

class UserListPresenter {

    weak var view: UserListViewProtocol?
    var interactor: UserListInteractorProtocol?
    var router: UserListRouterProtocol?
        
    var state: IdleState?
    var idleState: IdleState?
    var searchState: SearchState?
    var fetchState: FetchState?
    
    private var active: Bool {
        return state is FetchState || state is SearchState
    }
}

//MARK: UserListPresenterProtocol
extension UserListPresenter: UserListPresenterProtocol {
    
    func didSelect(at index: Int) -> Void {
        state?.didSelect(at: index)
    }
    
    func delete(at index: Int) {
        state?.delete(at: index)
    }
    
    func findUsers(by term: String) -> Void {
        state = searchState
        state?.findUsers(by: term)
    }
    
    func getUsers() -> Void {
        guard active else {
            state = fetchState
            state?.getUsers()
            return
        }
    }    
}

//MARK: UserListInteractorOutputProtocol
extension UserListPresenter: UserListInteractorOutputProtocol {
    func founded(_ users: [User]) {
        state?.founded(users)
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
