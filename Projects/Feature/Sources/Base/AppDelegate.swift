import UIKit
import AuthenticationServices

public final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // remove Constraint warning
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        return true
    }
}
