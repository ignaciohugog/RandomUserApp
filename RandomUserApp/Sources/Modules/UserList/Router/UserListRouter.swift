import UIKit
import Core
import RxSwift

enum UserListRouterEvent {
    case present(user: User)
}

class UserListRouter {
    private let disposeBag = DisposeBag()
    let input = PublishSubject<UserListRouterEvent>()
    weak var viewController: UIViewController?
    
    init() {
        input.subscribe(onNext: { event in
            switch event {
            case let .present(user):
                let userModule = UserModule.build(user)
                self.viewController?.navigationController?.pushViewController(userModule, animated: true)
            }}).disposed(by: disposeBag)
    }
}

