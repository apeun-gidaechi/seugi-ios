import UIKit
import AuthenticationServices

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // Authorization Logic
//                break
//            case .revoked, .notFound:
//                // Unauthorization Logic
//                break
//            default:
//                break
//            }
//        }
        return true
    }
    
}
