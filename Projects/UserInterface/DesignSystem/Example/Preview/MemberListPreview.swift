//
//  MemberListPreview.swift
//  DesignSystemExample
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct MemberListPreview: View {
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SeugiMemberList(type: .normal)
                SeugiMemberList(type: .normal) {
                    Image(icon: .checkLine)
                        .renderingMode(.template)
                        .seugiColor(.primary(.p500))
                }
                SeugiMemberList(type: .invitation)
            }
        }
    }
}
