//
//  OnboardingView.swift
//  StartFeature
//
//  Created by dgsw8th71 on 3/30/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct OnboardingView: View {
    
    @StateObject private var onboardingNavController = OnboardingNavigationController()
    
    public var body: some View {
        NavigationStack(path: $onboardingNavController.path) {
            StartView()
        }
    }
}
