import Core

enum UserPresenterEvent {
    case viewDidLoad
}

class UserPresenter {

    var user: User?
    let formatter = DateFormatter()
    
    var view: UserViewSubject?
    var observer = UserPresenterSubject()
    
    init() {
        subscribe()
        formatter.dateStyle = .short        
    }
    
    func subscribe() {
        observer.subject.subscribe(onNext: { event in
            switch event {
            case .viewDidLoad:
                guard let user = self.user else { return }
                self.view?.subject.onNext(.show(user: self.prepareForView(user)))
            }
        }).disposed(by: observer.disposeBag)
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
