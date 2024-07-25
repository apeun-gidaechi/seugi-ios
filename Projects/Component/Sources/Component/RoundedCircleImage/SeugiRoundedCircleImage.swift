//
//  SeugiRoundedCircleImage.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/29/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import SwiftUIUtil

public struct SeugiRoundedCircleImage: View {
    
    private let type: SeugiRoundedCircleImageType
    private let size: SeugiRoundedCircleImageType.Size
    
    private init(
        type: SeugiRoundedCircleImageType,
        size: SeugiRoundedCircleImageType.Size
    ) {
        self.type = type
        self.size = size
    }
    
    public var body: some View {
        Group {
            switch type {
            case .icon(let icon):
                Image(icon: icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: size.rawValue / 9 * 5, height: size.rawValue / 9 * 5)
                    .seugiColor(.gray(.g400))
                    
            case .image(let image):
                Image(image: image)
                    .resizable()
                    .frame(width: .infinity, height: .infinity)
            }
        }
        .frame(width: size.rawValue, height: size.rawValue)
        .seugiBackground(.gray(.g100))
        .cornerRadius(size.rawValue * 16 / 45, corners: .allCorners)
        .if(!type.isIcon) { view in
            view.stroke(size.rawValue * 16 / 45, content: Color.seugi(.gray(.g400)), lineWidth: 2)
        }
    }
}

public extension SeugiRoundedCircleImage {
    
    static func large(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .large)
    }
    
    static func medium(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .medium)
    }
    
    static func small(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .small)
    }
    
    static func extraSmall(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .extraSmall)
    }
}
