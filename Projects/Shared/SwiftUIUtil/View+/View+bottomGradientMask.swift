//
//  View+gradientMask.swift
//  DateUtil
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension View {
    func bottomGradientMask(
        height: CGFloat = 120
    ) -> some View {
        self.mask(alignment: .bottom) {
            VStack(spacing: 0) {
                Color.black
                LinearGradient(
                    colors: [.black, .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: height)
            }
            .ignoresSafeArea()
        }
    }
}
