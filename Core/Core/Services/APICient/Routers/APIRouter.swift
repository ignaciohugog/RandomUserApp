import Foundation
import Alamofire

struct Constants {
  static let baseURL = "https://randomuser.me/api/"
}

enum HTTPHeaderField: String {
  case contentType = "Content-Type"
  case acceptType = "Accept"
}

enum ContentType: String {
  case json = "application/json"
}

protocol APIConfiguration: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: Parameters? { get }
}

extension APIConfiguration {
  
  func asURLRequest() throws -> URLRequest {
    let url = try Constants.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    if let parameters = parameters {
      do {
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
      } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    
    return urlRequest
  }
}


