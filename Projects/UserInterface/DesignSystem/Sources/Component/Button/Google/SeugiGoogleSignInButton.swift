//
//  SeugiGoogleSignInButton.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/11/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiGoogleSignInButton: UIViewControllerRepresentable {
    
    private let clientId: String
    
    public init(
        clientId: String
    ) {
        self.clientId = clientId
    }
    
    public func makeUIViewController(context: Context) -> GoogleVC {
        let googleVC = GoogleVC()
        googleVC.setClientId(clientId)
        return googleVC
    }
    
    public func updateUIViewController(_ uiViewController: GoogleVC, context: Context) {
        //
    }
}
