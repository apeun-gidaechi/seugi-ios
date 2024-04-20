//
//  SeugiAppIcon.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/20/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiAppIcon: View {
    
    private let type: SeugiAppIconType
    
    public init(type: SeugiAppIconType) {
        self.type = type
    }
    
    public var body: some View {
        Image(image: .appIcon)
            .resizable()
            .frame(width: type.size, height: type.size)
    }
}
