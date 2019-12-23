import UIKit
import Core
import RxSwift

class UserViewSubject {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<UserViewEvent>()
}

class UserPresenterSubject {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<UserPresenterEvent>()
}

class UserModule {

    static func build(_ user: User) -> UIViewController {
                        
        let view = UserView()
        let presenter = UserPresenter()
                                
        presenter.user = user
        presenter.view = view.observer
        view.presenter = presenter.observer
        
        return view
    }    
}
