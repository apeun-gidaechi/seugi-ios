//
//  DesignSystemApp.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

@main
struct DesignSystemApp: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SeugiPreview.preview
        }
    }
}
