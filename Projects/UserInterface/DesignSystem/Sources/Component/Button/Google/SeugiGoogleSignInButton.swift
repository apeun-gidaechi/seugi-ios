//
//  SeugiGoogleSignInButton.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/11/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiGoogleSignInButton: UIViewControllerRepresentable {
    
    public init() {}
    
    public func makeUIViewController(context: Context) -> GoogleVC {
        let googleVC = GoogleVC()
        return googleVC
    }
    
    public func updateUIViewController(_ uiViewController: GoogleVC, context: Context) {
        //
    }
}
