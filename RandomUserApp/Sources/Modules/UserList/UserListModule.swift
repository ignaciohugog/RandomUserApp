import UIKit
import RxSwift

class UserListModule {

    static func build() -> UIViewController {
        
        
        let view = UserListView()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        let presenter = UserListPresenter()

        presenter.outputView = view.input
        presenter.outputRouter = router.input
        presenter.outputInteractor = interactor.input
                       
        let idleState = IdleState(presenter: presenter)
        let searchState = SearchState(presenter: presenter)
        let fetchState = FetchState(presenter: presenter)
        
        presenter.state = idleState
        presenter.idleState = idleState
        presenter.fetchState = fetchState
        presenter.searchState = searchState
        
        view.output = presenter.inputPresenter
        interactor.output = presenter.inputInteractor
        router.viewController = view
        
        return view
    }    
}
