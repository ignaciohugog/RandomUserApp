import UIKit
import Core

class UserModule {

    static func build(_ user: User) -> UIViewController {
        let view = UserView()
        let presenter = UserPresenter()
        presenter.user = user
        presenter.view = view
        view.presenter = presenter
        
        return view
    }    
}
