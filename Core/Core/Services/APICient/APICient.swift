import Alamofire
import PromiseKit

class APIClient {
  @discardableResult
  class func request<T: Decodable>(_ route: APIConfiguration,
                                   _ decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
    
    return Promise<T> { seal in
        
      AF.request(route)
        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
        switch response.result {
        case .success(let value):
          seal.fulfill(value)
        case .failure(let error):
            print(error)
          seal.reject(error)
        }
      }
    }
  }
}
