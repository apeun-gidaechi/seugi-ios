//
//  View+rootController.swift
//  SwiftUIUtil
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

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
