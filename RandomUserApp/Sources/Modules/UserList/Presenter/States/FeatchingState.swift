import Core

class FeatchingState: IdleState {
    
    override func getUsers() {
        guard let interactor = presenter?.interactor else { return }
        users.isEmpty ? interactor.loadUsers() : interactor.fetchUsers()
    }
    
    override func founded(_ users: [User]) {
        self.users += users
        presenter?.idleState?.users = self.users
        presenter?.state = presenter?.idleState
        presenter?.state?.show()
    }
}
