import Core

class UserListPresenter {

    weak var view: UserListViewProtocol?
    var interactor: UserListInteractorProtocol?
    var router: UserListRouterProtocol?
    
    private var users = [User]()
    
    var state: IdleState?
    var idleState: IdleState?
    var fetchingState: FeatchingState?
    
    private var active: Bool {
        return state is FeatchingState
    }
}

//MARK: UserListPresenterProtocol
extension UserListPresenter: UserListPresenterProtocol {
    func getUsers() -> Void {
        guard active else {
            state = fetchingState
            state?.getUsers()
            return
        }
    }
    
    func didSelect(at index: Int) -> Void {
         state?.didSelect(at: index)
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
