import Core

class UserListPresenter {

    weak var view: UserListViewProtocol?
    var interactor: UserListInteractorProtocol?
    var router: UserListRouterProtocol?
        
    var state: IdleState?
    var idleState: IdleState?
    var fetchingState: FeatchingState?
    
    private var active: Bool {
        return state is FeatchingState
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
    
    func getUsers() -> Void {
        guard active else {
            state = fetchingState
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
    class func prepareForView(_ user: User) -> UpcomingDisplayUser {
        return UpcomingDisplayUser(name: [user.name, user.surname].joined(separator: " "),
                                   email: user.email,
                                   phone: user.phone,
                                   image: user.picture)
    }
}
