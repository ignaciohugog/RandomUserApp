import Foundation
import XCTest
@testable import Core

class UserDTOTests: XCTestCase {
    func test_UserDTO_givenValidJSON_initializes() {
        // Arrange
        guard let data = dataFromJson("valid_user") else {
            XCTFail("Fail loading JSON")
            return
        }
        // Act
        let model = try? userDecoder.decode(UserDTO.self, from: data)
        // Assert
        XCTAssertNotNil(model)
    }
    
    func test_UserDTO_givenInValidJSON_returnsNil() {
        // Arrange
        guard let data = dataFromJson("invalid_user") else {
            XCTFail("Fail loading JSON")
            return
        }
        // Act
        let model = try? userDecoder.decode(UserDTO.self, from: data)
        // Assert
        XCTAssertNil(model)
    }
    
    // MARK: Helpers
    private func dataFromJson(_ name: String) -> Data? {
        guard let path = jsonPath(for: name) else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    private func jsonPath(for resource: String) -> String? {
        let bundle = Bundle(for: type(of: self))
        return bundle.path(forResource: resource, ofType: "json")
    }
    
    var userDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return jsonDecoder
    }
}
