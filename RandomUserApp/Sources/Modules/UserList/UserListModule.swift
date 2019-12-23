import UIKit
import RxSwift

class UserListModule {

    static func build() -> UIViewController {
        
        
        let view = UserListView()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        let presenter = UserListPresenter()

        presenter.view = view.observer
        presenter.router = router.observer
        presenter.interactor = interactor.observer
                       
        let idleState = IdleState(presenter: presenter)
        let searchState = SearchState(presenter: presenter)
        let fetchState = FetchState(presenter: presenter)
        
        presenter.state = idleState
        presenter.idleState = idleState
        presenter.fetchState = fetchState
        presenter.searchState = searchState
        
        view.presenter = presenter.observer
        interactor.presenter = presenter.observerInteractor
        router.viewController = view
        
        return view
    }    
}
