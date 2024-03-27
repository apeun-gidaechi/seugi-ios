//
//  LaunchScreen.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct LaunchScreenView: View {
    
    public init() {}
    
    public var body: some View {
        SeugiAvatar(type: .extraLarge)
            .toCenter()
    }
}
