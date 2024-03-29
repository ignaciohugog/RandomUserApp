import UIKit
import Core

class UserListRouter {
    weak var viewController: UIViewController?
}

extension UserListRouter: UserListRouterProtocol{
    func present(_ user: User) -> Void{
        let userModule = UserModule.build(user)
        viewController?.navigationController?.pushViewController(userModule, animated: true)
    }
}
