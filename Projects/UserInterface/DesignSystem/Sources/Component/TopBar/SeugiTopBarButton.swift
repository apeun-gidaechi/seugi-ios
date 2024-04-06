//
//  SeugiTopBarButton.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiTopBarButton {
    
    public let icon: Image
    public let action: () -> Void
    
    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}
