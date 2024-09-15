//
//  LaunchScreen.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

struct LaunchScreenView: View {
    var body: some View {
        SeugiAppIcon(type: .extraLarge)
            .toCenter()
            .seugiBackground(.sub(.white))
    }
}
