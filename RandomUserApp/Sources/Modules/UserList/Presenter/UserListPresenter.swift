import UIKit
import Core

class UserListPresenter: UserListPresenterProtocol {
    

    weak var view: UserListViewProtocol?
    var interactor: UserListInteractorProtocol?
    var router: UserListRouterProtocol?
    
    private var users = [User]()
    
    func getUsers() {
        interactor?.loadUsers()
    }

}

extension UserListPresenter: UserListInteractorOutputProtocol {
    func founded(_ users: [User]) {
        self.users += users
        view?.show(users.map{UserListPresenter.prepareForView($0)})
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
