import UIKit
import Core
import RxSwift

class UserModule {

    static func build(_ user: User) -> UIViewController {
        let viewSubject = PublishSubject<UserViewEvent>()
        let presenterSubject = PublishSubject<UserPresenterEvent>()
                        
        let view = UserView(viewSubject)
        let presenter = UserPresenter(presenterSubject)
                                
        presenter.user = user
        presenter.view = viewSubject
        view.presenter = presenterSubject
        
        return view
    }    
}
