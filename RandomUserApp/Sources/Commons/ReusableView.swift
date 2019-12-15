protocol ReusableView: class {}

extension ReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
