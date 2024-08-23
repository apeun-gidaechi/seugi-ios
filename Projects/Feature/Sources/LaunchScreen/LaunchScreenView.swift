//
//  LaunchScreen.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

public struct LaunchScreenView: View {
    
    public init() {}
    
    public var body: some View {
        SeugiAppIcon(type: .extraLarge)
            .toCenter()
            .seugiBackground(.sub(.white))
    }
}
