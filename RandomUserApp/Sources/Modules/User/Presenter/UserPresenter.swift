import Core

class UserPresenter: UserPresenterProtocol {

    var user: User?
    weak var view: UserViewProtocol?
    
    let formatter = DateFormatter()
    
    init() {
        formatter.dateStyle = .short
    }
    
    func viewDidLoad() -> Void {
        guard let user = user else { return }
        view?.show(prepareForView(user))
    }
}

extension UserPresenter {
    func prepareForView(_ user: User) -> UpcomingDisplayUserDetail {
        
        return UpcomingDisplayUserDetail(name: [user.name, user.surname].joined(separator: " "),
                                         image: user.picture,
                                         email: user.email,
                                         gender: user.gender,
                                         location: [user.street, user.city, user.state].joined(separator: ", "),
                                         registeredDate: formatter.string(from: user.registered))
    }
}
