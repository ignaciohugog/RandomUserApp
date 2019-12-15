import Foundation
import Alamofire

enum UserAPIRouter: APIConfiguration {
    case users
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    var parameters: Parameters? {
        switch self {
        case .users:
            return ["results" : 20]
        }
    }
}

