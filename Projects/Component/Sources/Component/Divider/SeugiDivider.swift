//
//  SeugiDivider.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiDivider: View {
    
    var thickness: Thickness
    var direction: Self.Direction
    
    public init(thickness: Thickness, 
                direction: Self.Direction = .horizontal) {
        self.thickness = thickness
        self.direction = direction
    }
    
    public var body: some View {
        Group {
            switch (thickness, direction) {
            case (.thick, .horizontal):
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 8)
            case (.thick, .vertical):
                Rectangle()
                    .frame(maxHeight: .infinity)
                    .frame(width: 8)
            case (.thin, .horizontal):
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
            case (.thin, .vertical):
                Rectangle()
                    .frame(maxHeight: .infinity)
                    .frame(width: 1)
            }
        }
        .seugiColor(.gray(.g200))
    }
}
