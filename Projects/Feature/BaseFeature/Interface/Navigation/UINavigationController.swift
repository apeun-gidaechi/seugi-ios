//
//  UINavigationController.swift
//  BaseFeature
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
