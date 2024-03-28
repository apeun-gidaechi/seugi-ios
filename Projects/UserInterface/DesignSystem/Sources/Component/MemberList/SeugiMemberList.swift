//
//  SeugiMemberList.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiMemberList<Content>: View where Content: View {
    
    private var type: SeugiMemberListType
    private var content: (() -> Content)?
    
    public init(type: SeugiMemberListType = .normal,
                content: (() -> Content)? = { EmptyView() }) {
        self.type = type
        self.content = content
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            if case .invitation = type {
                DesignSystemAsset.addRingLine.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiForeground(.primary(.p400))
            } else {
                SeugiAvatar(type: .large)
            }
            if case .invitation = type {
                Text("멤버 초대하기")
                    .font(.seugi(.subtitle2))
                    .seugiForeground(.primary(.p400))
            } else {
                Text("노영재")
                    .font(.seugi(.subtitle2))
                    .seugiForeground(.sub(.black))
            }
            Spacer()
            content?()
        }
        .padding(16)
    }
}
