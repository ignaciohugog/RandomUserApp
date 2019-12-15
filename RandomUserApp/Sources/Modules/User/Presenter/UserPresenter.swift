import Core

class UserPresenter: UserPresenterProtocol {

    var user: User?
    weak var view: UserViewProtocol?
    
    func viewDidLoad() -> Void {
        guard let user = user else { return }
        view?.show(UserPresenter.prepareForView(user))
    }
}

extension UserPresenter {
    class func prepareForView(_ user: User) -> UpcomingDisplayUserDetail {
        
        return UpcomingDisplayUserDetail(name: [user.name, user.surname].joined(separator: " "),
                                         image: user.picture,
                                         email: user.email,
                                         gender: user.gender,
                                         location: "location",
                                         registeredDate: "date")
    }
}
