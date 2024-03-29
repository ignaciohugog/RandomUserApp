import Core

class FetchState: IdleState {
    
    override func getUsers() -> Void {
        guard let interactor = presenter?.interactor,
        let usersLoaded = presenter?.idleState?.users else { return }
        
        usersLoaded.isEmpty ? interactor.loadUsers() : interactor.fetchUsers()
    }
    
    override func didSelect(at index: Int) -> Void {
        presenter?.idleState?.didSelect(at: index)
    }
    
    override func delete(at index: Int) -> Void {
        presenter?.idleState?.delete(at: index)
    }
    
    override func founded(_ users: [User]) -> Void {
        presenter?.idleState?.users += users
        presenter?.state = presenter?.idleState
        presenter?.state?.show()
    }
}
