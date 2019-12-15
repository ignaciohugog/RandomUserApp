import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personEmailLabel: UILabel!
    @IBOutlet weak var personPhoneLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    override func prepareForReuse() {
        personImageView.image = nil
     }
    
    func configure(_ user: UpcomingDisplayUser) {
        personNameLabel.text = user.name
        personEmailLabel.text = user.email
        personPhoneLabel.text = user.phone
        personImageView.setImage(from: user.image)
    }
}
