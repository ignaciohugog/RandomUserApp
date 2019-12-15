import Foundation

public class ServiceLocator {
  public static let sharedLocator = ServiceLocator()
  
  private var registry = [ObjectIdentifier: Any]()
  
  public func register<Service>(_ service: Service) {
    registry[ObjectIdentifier(Service.self)] = service
  }
  
  public static func inject<Service>() -> Service {
    return sharedLocator.inject()
  }
  
  private func inject<Service>() -> Service {
    guard let service = registry[ObjectIdentifier(Service.self)] as? Service else {
      fatalError("No registered entry for \(Service.self)")
    }
    return service
  }
}

