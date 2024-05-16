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
    
    var type: SeugiRoundedCircleImageType
    var size: SeugiRoundedCircleImageType.Size
    
    private init(
        type: SeugiRoundedCircleImageType,
        size: SeugiRoundedCircleImageType.Size
    ) {
        self.type = type
        self.size = size
    }
    
    public var body: some View {
        let imageSize = type.getImageSize(size: size)
        ZStack {
            switch type {
            case .fill:
                type.image
                    .resizable()
                    .frame(maxWidth: imageSize, maxHeight: imageSize)
                    .stroke(size.roundedCorner, content: Color.seugi(.gray(.g400)), lineWidth: 2)
            default:
                type.image
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: imageSize, height: imageSize)
                    .seugiColor(.gray(.g400))
            }
        }
        .frame(width: size.rawValue, height: size.rawValue)
        .background(Color.seugi(.gray(.g100)))
        .cornerRadius(size.roundedCorner, corners: .allCorners)
    }
}

public extension SeugiRoundedCircleImage {
    static func large(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .large)
    }
    
    static func small(type: SeugiRoundedCircleImageType) -> Self {
        .init(type: type, size: .small)
    }
}
