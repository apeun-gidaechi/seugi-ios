import SwiftUI
import UIKit

public extension UIApplication {
    var scene: UIWindowScene? {
        connectedScenes.first as? UIWindowScene
    }
    
    var screen: UIScreen? {
        scene?.screen
    }
    
    var window: UIWindow? {
        scene?.keyWindow
    }
    
    var rootController: UIViewController? {
        window?.rootViewController
    }
}
