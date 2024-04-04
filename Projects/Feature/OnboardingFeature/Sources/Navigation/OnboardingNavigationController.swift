//
//  OnboardingNavigationController.swift
//  OnboardingFeature
//
//  Created by dgsw8th71 on 3/30/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import BaseFeature

public final class OnboardingNavigationController: ObservableObject {
    @Published public var path: [ViewType.Onboarding] = []
    
    public func navigateTo(_ view: ViewType.Onboarding) {
        path.append(view)
    }
    
    public func navigateToRootView() {
        path.removeAll()
    }
    
    public func replacePath(_ views: [ViewType.Onboarding]) {
        path = views
    }
}
