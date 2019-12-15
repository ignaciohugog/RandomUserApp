import Foundation

//MARK: Presenter
protocol UserPresenterProtocol: class {
    func viewDidLoad() -> Void
}

//MARK: View
protocol UserViewProtocol: class {

    var presenter: UserPresenterProtocol?  { get set }
    func show(_ user: UpcomingDisplayUserDetail) -> Void
}
