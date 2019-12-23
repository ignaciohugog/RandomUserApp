import XCTest
import RxSwift
@testable import Core
@testable import RandomUserApp

class UserListTest: XCTestCase {
    let view = UserListView()
    let interactor = UserListInteractor()
    let presenter = UserListPresenter()
    let router = UserListRouter()
    
    override func setUp() {
        presenter.outputView = view.input
        presenter.outputRouter = router.input
        presenter.outputInteractor = interactor.input
        
        view.output = presenter.inputPresenter
        interactor.output = presenter.inputInteractor
        router.viewController = view
        
        presenter.state = IdleState(presenter: presenter)
        presenter.searchState = SearchState(presenter: presenter)
        presenter.fetchState = FetchState(presenter: presenter)
        presenter.idleState = presenter.state
    }
    
    func test_viewDidLoad_whithNoUsers_rendersZeroUsers() {
        // Arrange
        let totalUsers = 0
        interactor.repository = MockUserRepository(totalUsers)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), totalUsers)
        }
    }
    
    func test_viewDidLoad_whithOneUser_rendersOneUser() {
        // Arrange
        let totalUsers = 1
        interactor.repository = MockUserRepository(totalUsers)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), totalUsers)
        }
    }
    
    func test_viewDidLoad_whithNusers_rendersNusers() {
        // Arrange
        let totalUsers = 10
        interactor.repository = MockUserRepository(totalUsers)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), totalUsers)
        }
    }
    
    func test_viewDidLoad_whenServiceFails_rendersZeroUsers() {
        // Arrange
        interactor.repository = MockFailUserRepository()
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 0)
        }
    }
    
    func test_viewDidLoad_whithOneUser_renderCellWithUserInfo() {
        // Arrange
        let totalUsers = 1
        interactor.repository = MockUserRepository(totalUsers)
        // Act
        view.loadViewIfNeeded()
        onBackground {
            let cell = self.tableView().cell(at: 0) as? UserTableViewCell
            XCTAssertEqual(cell?.userEmailLabel.text, "anEmail")
            XCTAssertEqual(cell?.userPhoneLabel.text, "1234")
        }
    }
    
    
    func test_viewDidLoad_hasPersistedUsers_rendersPersistedUsers() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let _ = store.saveUsers(dtos: [UserDTO(name:"Ignacio")]).subscribe()
        interactor.repository = UserRepository(store: store)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            let cell = self.tableView().cell(at: 0) as? UserTableViewCell
            XCTAssertEqual(cell?.userNameLabel.text, "Ignacio ")
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 1)
        }
    }
    
    func test_navigation_whenRowSelected_navigateToUserView() {
        // Arrange
        let totalUsers = 1
        interactor.repository = MockUserRepository(totalUsers)
        let navigation = UINavigationController(rootViewController: view)
        // Act
        view.loadViewIfNeeded()
        onBackground {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView().delegate?.tableView?(self.view.tableView, didSelectRowAt: indexPath)
        }
        // Assert
        onBackground(0.2) {
            XCTAssert(navigation.topViewController is UserView)
        }
    }
    
    func test_userView_whenRowSelected_rendersUserView() {
        // Arrange
        let totalUsers = 1
        interactor.repository = MockUserRepository(totalUsers)
        let navigation = UINavigationController(rootViewController: view)
        // Act
        view.loadViewIfNeeded()
        onBackground {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView().delegate?.tableView?(self.view.tableView, didSelectRowAt: indexPath)
        }
        onBackground(0.2) {
            navigation.topViewController?.loadViewIfNeeded()
        }
        // Assert
        onBackground(0.3) {
            let userView = navigation.topViewController as? UserView
            XCTAssertEqual(userView?.userEmailLabel.text, "anEmail")
            XCTAssertEqual(userView?.userGenderLabel.text, "male")
        }
    }
    
    func test_prefetchUsers_whenScrollAfterFirstLoad_rendersMoreUsers() {
        // Arrange
        let storedUsers = 10
        let responseUsers = 20
        interactor.repository = MockUserRepository(storedUsers, responseUsers)
        // Act
        view.loadViewIfNeeded()
        onBackground {
            let indexPath = IndexPath(row: 9, section: 0)
            self.tableView().prefetchDataSource?.tableView(self.tableView(), prefetchRowsAt: [indexPath])
        }
        // Assert
        onBackground(0.3) {
            XCTAssertEqual(self.view.tableView.numberOfRows(inSection: 0), 30)
        }
    }
    
    func test_viewDidLoad_givenDuplicateUsers_rendersNoDuplicateUsers() {
        // Arrange
        let storedUsers = 0
        let responseUsers = 4
        interactor.repository = MockDuplicateUserRepository(storedUsers, responseUsers)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 1)
        }
    }
    
    func test_deleteUser_onViewDidLoad_deleteUserCell() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let _ = store.saveUsers(dtos: [UserDTO(name:"")]).subscribe()
        interactor.repository = UserRepository(store: store)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView().dataSource?.tableView?(self.tableView(),commit: .delete, forRowAt: indexPath)
            XCTAssertEqual(self.view.tableView.numberOfRows(inSection: 0), 0)
        }
    }
    
//    func test_userBlacklisted_whenDeleteUserAndServiceReturnsDeletedUser_userDeletedIsNotShow() {
//        // Arrange
//        let storedUsers = 0
//        let responseUsers = 2
//        interactor.repository = MockUserRepository(storedUsers, responseUsers)
//                
//        // Act
//        view.loadViewIfNeeded()
//        onBackground {
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.tableView().dataSource?.tableView?(self.tableView(), commit: .delete, forRowAt: indexPath)
//        }
//        
//        // Assert
//        onBackground(0.2) {
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.tableView().prefetchDataSource?.tableView(self.tableView(), prefetchRowsAt: [indexPath])
//            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 1)
//        }
//    }
    
    func test_search_searchByName_renderResultsForGivenName() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let users = [UserDTO(name:"an"),
                     UserDTO(name:"ann"),
                     UserDTO(name:"b")]
        let _ = store.saveUsers(dtos: users).subscribe()
        interactor.repository = UserRepository(store: store)
        
        // Act
        view.loadViewIfNeeded()
        onBackground {
            self.view.searchController.searchBar.delegate?.searchBar?(self.view.searchController.searchBar, textDidChange: "a")
        }
        
        // Assert
        onBackground(0.2) {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 2)
        }
    }
    
    func test_search_searchBySurname_renderResultsForGivenSurname() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let users = [UserDTO(name: "", surname: "a", email: ""),
                     UserDTO(name: "", surname: "aan", email: ""),
                     UserDTO(name: "", surname: "b", email: "")]
        let _ = store.saveUsers(dtos: users).subscribe()
        interactor.repository = UserRepository(store: store)
        
        // Act
        view.loadViewIfNeeded()
        onBackground {
            self.view.searchController.searchBar.delegate?.searchBar?(self.view.searchController.searchBar, textDidChange: "a")
        }
        
        // Assert
        onBackground(0.2) {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 2)
        }
        
    }
    
    func test_search_searchByEmail_renderResultsForGivenEmail() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let users = [UserDTO(name: "", surname: "", email: "a"),
                     UserDTO(name: "", surname: "", email: "aan"),
                     UserDTO(name: "", surname: "", email: "b")]
        let _ = store.saveUsers(dtos: users).subscribe()
        interactor.repository = UserRepository(store: store)
        
        // Act
        view.loadViewIfNeeded()
        onBackground {
            self.view.searchController.searchBar.delegate?.searchBar?(self.view.searchController.searchBar, textDidChange: "a")
        }
        
        // Assert
        onBackground(0.2) {
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 2)
        }
    }
    
    //MARK: Helpers methods
    
    func onBackground(_ delay: Double = 0.1, _ assert: @escaping  () -> Void) {
        let expectation = XCTestExpectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
          expectation.fulfill()
            assert()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func tableView() -> UITableView {
        return view.tableView
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
}
