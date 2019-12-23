import UIKit
import RxSwift

enum UserViewEvent {
    case show(user: UpcomingDisplayUserDetail)
}

class UserView: UIViewController {
        
    var presenter: PublishSubject<UserPresenterEvent>?
    
    private let disposeBag = DisposeBag()
            
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userRegisteredLabel: UILabel!
    
    convenience init(_ subject: PublishSubject<UserViewEvent>) {
        self.init()
        subscribe(subject)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onNext(.viewDidLoad)
    }
    
    func subscribe(_ subject: PublishSubject<UserViewEvent>) {
        subject.subscribe(onNext: { event in
            switch event {
            case let .show(user: user):
                self.show(user)
            }
            }).disposed(by: disposeBag)
    }
    
    func show(_ user: UpcomingDisplayUserDetail) {
        title = user.name
        userImageView.setImage(from: user.image)
        userEmailLabel.text = user.email
        userGenderLabel.text = user.gender
        userLocationLabel.text = user.location
        userRegisteredLabel.text = user.registeredDate
    }
}

