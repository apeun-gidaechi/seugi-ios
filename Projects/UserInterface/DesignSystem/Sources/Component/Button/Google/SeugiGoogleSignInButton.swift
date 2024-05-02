//
//  SeugiGoogleSignInButton.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/11/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiGoogleSignInButton: UIViewControllerRepresentable {
    
    private let onSuccess: (_ idToken: String) async -> Void
    private let onFailure: () async -> Void
    
    public init(
        onSuccess: @escaping (_: String) async -> Void,
        onFailure: @escaping () async -> Void
    ) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    public func makeUIViewController(context: Context) -> GoogleVC {
        let googleVC = GoogleVC()
        googleVC.onSuccess = onSuccess
        googleVC.onFailure = onFailure
        return googleVC
    }
    
    public func updateUIViewController(_ uiViewController: GoogleVC, context: Context) {
        //
    }
}
