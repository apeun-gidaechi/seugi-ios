//
//  SecondCreateRoomView.swift
//  CreateRoomFeature
//
//  Created by dgsw8th71 on 4/4/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import DesignSystem

public struct SecondCreateRoomView: View {
    
    @State private var roomTitle = ""
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            SeugiTextField("노영재 1세 외 3명", text: $roomTitle)
                .padding(.horizontal, 20)
            Spacer()
        }
        .seugiTopBar("")
        .subView {
            SeugiButton.small("완료", type: .transparent) {
                // handle navigate to CreateRoom-2
            }
        }
    }
}
