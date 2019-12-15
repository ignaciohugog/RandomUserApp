import UIKit
import CoreData
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appDependencies = AppDependencies()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        appDependencies.start(window)
        
        return true
    }
}

