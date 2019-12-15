import Core

class FeatchingState: IdleState {
    
    override func getUsers() {
        guard let interactor = presenter?.interactor,
        let usersLoaded = presenter?.idleState?.users else { return }
        
        usersLoaded.isEmpty ? interactor.loadUsers() : interactor.fetchUsers()
    }
    
    override func founded(_ users: [User]) {
        presenter?.idleState?.users += users
        presenter?.state = presenter?.idleState
        presenter?.state?.show()
    }
}
