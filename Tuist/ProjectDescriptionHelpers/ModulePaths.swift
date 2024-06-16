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
    case data(Data)
    case shared(Shared)
}

public extension ModulePaths {
    
    enum App: String, CaseIterable {
        case iOS
    }
    
    enum Feature: String, CaseIterable {
        case Base
        case Root
        case Onboarding
        case EmailSignUp
        case EmailVerification
        case EmailSignIn
        case LaunchScreen
        case OAuthSignUp
        case Start
        case JoinSchool
        case JoinSuccess
        case SchoolCode
        case SelectingJob
        case WaitingJoin
        case Main
        case Home
        case Chat
        case ChatDetail
        case CreateRoom
    }
    
    enum Data: String, CaseIterable {
        case Core
        case Network
        case Local
    }
    
    enum Shared: String, CaseIterable {
        case GlobalThirdPartyLibrary
        case SwiftUIUtil
        case SwiftUtil
        case DateUtil
        case Secret
    }
    
    enum Single: String {
        case DIContainer
        case Component
        case Domain
    }
}
