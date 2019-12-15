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
                       
        let idleState = IdleState(presenter: presenter)
        let searchState = SearchState(presenter: presenter)
        let fetchState = FetchState(presenter: presenter)
        
        presenter.state = idleState
        presenter.idleState = idleState
        presenter.fetchState = fetchState
        presenter.searchState = searchState
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }    
}
