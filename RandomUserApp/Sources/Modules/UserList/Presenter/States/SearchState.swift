import Foundation
import Core

class SearchState: IdleState {
    
    override func founded(_ users: [User]) -> Void {
        self.users = users
        show()
    }
    
    override func delete(at index: Int) -> Void {
        let user = users.remove(at: index)
        guard let index = presenter?.idleState?.users.firstIndex(
            where: { $0.userID == user.userID }) else { return }
        
        presenter?.idleState?.delete(at: index)
    }
    
    override func findUsers(by term: String) -> Void {
        guard !term.isEmpty else {
            users.removeAll()
            presenter?.state = presenter?.idleState
            presenter?.state?.show()
            return
        }
        
        presenter?.interactor?.findUsers(by: term)
    }
}
