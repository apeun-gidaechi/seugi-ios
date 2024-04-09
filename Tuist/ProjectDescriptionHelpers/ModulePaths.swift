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
    case service(Domain)
    case shared(Shared)
    case userInterface(UserInterface)
}

public extension ModulePaths {
    
    enum App: String, CaseIterable {
        case App
    }
    
    enum Feature: String, CaseIterable {
        // base
        case Base
        
        // root
        case Root
        
        // onboarding
        case Onboarding // root
        case EmailSignUp
        case EmailSignIn
        case LaunchScreen
        case OAuthSignUp
        case SelectingJob
        case Start
        
        // join
        case JoinSchool // root
        case JoinSuccess
        case SchoolCode
        
        // main
        case Main // root
        case Home
        case Chat
        case ChatDetail
        case Room
        case CreateRoom
    }
    
    enum Domain: String, CaseIterable {
        case Base
        case Auth
    }
    
    enum Shared: String, CaseIterable {
        case GlobalThirdPartyLibrary
        case SwiftUIUtil
    }
    
    enum UserInterface: String, CaseIterable {
        case DesignSystem
    }
}
