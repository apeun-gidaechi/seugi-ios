//
//  ModulePaths.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import Foundation

public enum ModulePaths {
    case app(App)
    case feature(Feature)
    case service(Service)
    case shared(Shared)
    case userInterface(UserInterface)
}

public extension ModulePaths {
    
    enum App: String, CaseIterable {
        case App
    }
    
    enum Feature: String, CaseIterable {
        // base
        case BaseFeature
        
        // root
        case RootFeature
        
        // onboarding
        case OnboardingFeature
        // onboarding/sub
        case EmailSignUpFeature
        case EmailSignInFeature
        case JoinSchoolFeature
        case JoinSchoolSuccessFeature
        case LaunchScreenFeature
        case OAuthSignUpFeature
        case SelectingJobFeature
        case StartFeature
        
        // main
        case MainFeature
        
        // main/sub
        case HomeFeature
        case ChatFeature
        case ChatDetailFeature
    }
    
    enum Service: String, CaseIterable {
        case BaseService
        case AuthService
    }
    
    enum Shared: String, CaseIterable {
        case GlobalThirdPartyLibrary
        case SwiftUIUtil
    }
    
    enum UserInterface: String, CaseIterable {
        case DesignSystem
    }
}
