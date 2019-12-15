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
