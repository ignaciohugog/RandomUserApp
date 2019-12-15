import UIKit

class UserListModule {

    static func build() -> UIViewController {        
        let view = UserListView()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        let presenter = UserListPresenter()

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }    
}
