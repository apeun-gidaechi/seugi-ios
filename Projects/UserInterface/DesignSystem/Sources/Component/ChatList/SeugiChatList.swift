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
        HStack {
            SeugiAvatar(type: .large)
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .top) {
                    Text("노영재")
                        .font(.seugi(.subtitle2))
                        .seugiForeground(.sub(.black))
                    Spacer()
                    Text("12:39")
                        .font(.seugi(.body2))
                        .seugiForeground(.gray(.g500))
                }
                Text("나 사실...")
                    .font(.seugi(.body2))
                    .seugiForeground(.gray(.g600))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
