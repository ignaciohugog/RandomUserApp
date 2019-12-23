import UIKit

enum UserViewEvent {
    case show(user: UpcomingDisplayUserDetail)
}

class UserView: UIViewController {
        
    var observer = UserViewSubject()
    var presenter: UserPresenterSubject?
            
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userRegisteredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        presenter?.subject.onNext(.viewDidLoad)
    }
    
    private func subscribe() {
        observer.subject.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: observer.disposeBag)
    }
    
    private func handle(_ event: UserViewEvent) {
        switch event {
        case let .show(user: user):
            self.show(user)
        }
    }
    
    private func show(_ user: UpcomingDisplayUserDetail) {
        title = user.name
        userImageView.setImage(from: user.image)
        userEmailLabel.text = user.email
        userGenderLabel.text = user.gender
        userLocationLabel.text = user.location
        userRegisteredLabel.text = user.registeredDate
    }
}

