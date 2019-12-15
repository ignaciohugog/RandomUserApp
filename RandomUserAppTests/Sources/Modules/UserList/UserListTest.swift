import XCTest
@testable import Core
@testable import RandomUserApp

class UserListTest: XCTestCase {
    let view = UserListView()
    let interactor = UserListInteractor()
    let presenter = UserListPresenter()
    let router = UserListRouter()
    

    override func setUp() {
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
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
            XCTAssertEqual(cell?.personEmailLabel.text, "anEmail")
            XCTAssertEqual(cell?.personPhoneLabel.text, "1234")
        }
    }
    
    
    func test_viewDidLoad_hasPersistedUsers_rendersPersistedUsers() {
        // Arrange
        let store = CoreDataStore(container: MockPersistantContainer())
        let _ = store.saveUsers(dtos: [UserDTO(name:"Ignacio")])
        interactor.repository = UserRepository(store: store)
        // Act
        view.loadViewIfNeeded()
        // Assert
        onBackground {
            let cell = self.tableView().cell(at: 0) as? UserTableViewCell
            XCTAssertEqual(cell?.personNameLabel.text, "Ignacio ")
            XCTAssertEqual(self.tableView().numberOfRows(inSection: 0), 1)
        }
    }
    
    func test_navigation_whenRowSelected_navigateToPersonView() {
        // Arrange
        let totalUsers = 1
        interactor.repository = MockUserRepository(totalUsers)
        // Act
        view.loadViewIfNeeded()
        
        // Assert
        onBackground {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView().delegate?.tableView?(self.view.tableView, didSelectRowAt: indexPath)
            guard let navigation = self.router.viewController as? UINavigationController else { return }
            XCTAssert(navigation.topViewController is UserView)
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
