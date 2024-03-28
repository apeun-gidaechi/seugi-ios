//
//  SeugiChatList.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/27/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiChatList: View {
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 16) {
            SeugiAvatar(type: .large)
            VStack(alignment: .leading, spacing: 2) {
                Text("노영재")
                    .font(.seugi(.subtitle2))
                    .seugiForeground(.sub(.black))
                Text("나 사실...")
                    .font(.seugi(.body2))
                    .seugiForeground(.gray(.g600))
            }
            Spacer()
            VStack {
                Text("12:39")
                    .font(.seugi(.body2))
                    .seugiForeground(.gray(.g500))
                SeugiBadge(type: .number(72))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}
