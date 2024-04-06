//
//  SeugiChatList.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/27/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiChatList: View {
    
    private let type: SeugiChatListType
    
    public init(
        type: SeugiChatListType = .chat
    ) {
        self.type = type
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            SeugiAvatar(type: .large)
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .bottom, spacing: 4) {
                    Text("노영재")
                        .font(.seugi(.subtitle2))
                        .seugiColor(.sub(.black))
                    if case .people(let memberCount) = type {
                        Text("\(memberCount)")
                            .font(.seugi(.body2))
                            .seugiColor(.gray(.g500))
                    }
                }
                Text("나 사실...")
                    .font(.seugi(.body2))
                    .seugiColor(.gray(.g600))
            }
            Spacer()
            VStack(spacing: 4) {
                Text("12:39")
                    .font(.seugi(.body2))
                    .seugiColor(.gray(.g500))
                if case .people(let memberCount) = type,
                   memberCount > 0 {
                    SeugiBadge(type: .number(memberCount))
                }
            }
        }
        .background(Color.seugi(.sub(.white)))
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}
