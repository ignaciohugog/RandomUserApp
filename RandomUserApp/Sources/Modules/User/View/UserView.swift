import UIKit

class UserView: UIViewController {

	var presenter: UserPresenterProtocol?
    
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
        title = user.name
        userImageView.setImage(from: user.image)
        userEmailLabel.text = user.email
        userGenderLabel.text = user.gender
        userLocationLabel.text = user.location
        userRegisteredLabel.text = user.registeredDate
    }
}
