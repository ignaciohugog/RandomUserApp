import Alamofire
import RxSwift

class APIClient {
  @discardableResult
  class func request<T: Decodable>(_ route: APIConfiguration,
                                   _ decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
    
    return Single<T>.create { single in
          
        AF.request(route).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
          switch response.result {
          case .success(let value):
            single(.success(value))
          case .failure(let error):
            single(.error(error))
          }
        }
        
        return Disposables.create {}
    }
  }
}
