//
//  AlimoAvatar.swift
//  App
//
//  Created by dgsw8th71 on 2/3/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

public struct SeugiAvatar: View {
    
    var type: SeugiAvatarType
    
    public init(type: SeugiAvatarType
    ) {
        self.type = type
    }
    
    public var body: some View {
        Circle()
            .seugiColor(.primary(.p200))
            .frame(width: type.size, height: type.size)
            .overlay {
                DesignSystemAsset.personFill.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.primary(.p300))
                    .frame(width: type.size / 2, height: type.size / 2)
            }
    }
}
