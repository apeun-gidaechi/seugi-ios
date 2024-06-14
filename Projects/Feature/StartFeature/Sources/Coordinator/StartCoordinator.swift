//
//  StartCoordinator.swift
//  StartFeature
//
//  Created by dgsw8th71 on 4/10/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DIContainer
import OAuthSignUpFeatureInterface
import EmailSignInFeatureInterface
import SwiftUIUtil

public struct StartCoordinator: View {
    
    @Inject private var oAuthFactory: any OAuthSignUpFactory
    @Inject private var emailSignInFactory: any EmailSignInFactory
    
    public init() {}
    
    public var body: some View {
        StartView()
            .navigationDestination(for: StartDestination.self) {
                switch $0 {
                case .EmailSignIn: emailSignInFactory.makeView().eraseToAnyView()
                case .OAuthSignUp: oAuthFactory.makeView().eraseToAnyView()
                }
            }
    }
}
