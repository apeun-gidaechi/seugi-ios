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
    
    var window: UIWindow? {
        scene?.windows.first
    }
    
    var rootController: UIViewController? {
        window?.rootViewController
    }
}
