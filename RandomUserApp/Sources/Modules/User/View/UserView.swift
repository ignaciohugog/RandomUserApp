import UIKit
import RxSwift

enum UserViewEvent {
    case show(user: UpcomingDisplayUserDetail)
}

class UserView: UIViewController {
        
    private var disposeBag = DisposeBag()
    let input = PublishSubject<UserViewEvent>()
    var output: PublishSubject<UserPresenterEvent>?
            
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userRegisteredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.subscribe(onNext: { event in
            self.handle(event)
        }).disposed(by: disposeBag)
        
        output?.onNext(.viewDidLoad)
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

