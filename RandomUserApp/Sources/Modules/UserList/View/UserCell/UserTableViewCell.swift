import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func prepareForReuse() -> Void {
        userImageView.image = nil
     }
    
    func configure(_ user: UpcomingDisplayUser) -> Void {
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        userPhoneLabel.text = user.phone
        userImageView.setImage(from: user.image)
    }
}
