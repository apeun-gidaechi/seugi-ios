//
//  MainNavigationController.swift
//  MainFeature
//
//  Created by dgsw8th71 on 3/30/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import BaseFeature

public final class MainNavigationController: ObservableObject {
    @Published public var path: [ViewType.Main] = []
    
    public func navigateTo(_ view: ViewType.Main) {
        path.append(view)
    }
    
    public func navigateToRootView() {
        path.removeAll()
    }
}