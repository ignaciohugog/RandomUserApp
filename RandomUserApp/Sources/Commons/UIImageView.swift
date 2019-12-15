import UIKit
import Kingfisher

extension UIImageView {
  
  func setImage(from urlString: String?, placeholder: UIImage? = nil) {
    kf.indicatorType = .activity
    
    if let urlString = urlString {
      kf.setImage(with: URL(string: urlString), placeholder: placeholder)
    } else {
      image = UIImage(named: "placeholder")
    }
  }
}


