//
//  View+applyCardView.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import Component

extension View {
    func applyCardEffect() -> some View {
        self
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .padding(.bottom, 16)
            .seugiBackground(.sub(.white))
            .cornerRadius(12, corners: .allCorners)
            .shadow(.evBlack(.ev1))
    }
}

