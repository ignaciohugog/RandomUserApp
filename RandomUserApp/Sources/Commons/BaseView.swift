import Foundation
import UIKit

protocol BaseView: class {
  func showAlert(with error: Error)
}

extension UIViewController: BaseView {
  func showAlert(with error: Error) {
    showAlert(title: "Ups", message: "An error has occurred")
  }
  
  private func showAlert(title: String, message: String) {
    let alertViewController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
    
    alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    present(alertViewController, animated: true, completion: nil)
  }
}

