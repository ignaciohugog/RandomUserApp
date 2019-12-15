import UIKit

class UserView: UIViewController {

	var presenter: UserPresenterProtocol?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userRegisteredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension UserView: UserViewProtocol {
    func show(_ user: UpcomingDisplayUserDetail) {
        userImageView.setImage(from: user.image)
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        userGenderLabel.text = user.gender
        userLocationLabel.text = user.location
        userRegisteredLabel.text = user.registeredDate
    }
}
