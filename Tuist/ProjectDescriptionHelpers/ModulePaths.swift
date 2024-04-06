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
        case OnboardingFeature // root
        case EmailSignUpFeature
        case EmailSignInFeature
        case LaunchScreenFeature
        case OAuthSignUpFeature
        case SelectingJobFeature
        case StartFeature
        
        // join
        case JoinSchoolFeature // root
        case JoinSuccessFeature
        case SchoolCodeFeature
        
        // main
        case MainFeature // root
        case HomeFeature
        case ChatFeature
        case ChatDetailFeature
        case RoomFeature
        case CreateRoomFeature
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
