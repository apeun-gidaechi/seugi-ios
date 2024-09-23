//
//  ChatItemPreview.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

public struct ChatItemPreview: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ChatItemDetailView(text: "2024년 3월 21일 목요일")
                // MARK: - Other
//                ChatItemView(author: .mock(), message: .mock(), type: .other, joinedUserCount: 100)
                ChatItemView(
                    author: .mock(),
                    type: .other,
                    config: .init(
                        message: .mock(),
                        isFirst: true,
                        isLast: false,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .other,
                    config: .init(
                        message: .mock(),
                        isFirst: false,
                        isLast: false,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .other,
                    config: .init(
                        message: .mock(),
                        isFirst: false,
                        isLast: true,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .me,
                    config: .init(
                        message: .mock(),
                        isFirst: true,
                        isLast: false,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .me,
                    config: .init(
                        message: .mock(),
                        isFirst: false,
                        isLast: false,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .me,
                    config: .init(
                        message: .mock(),
                        isFirst: false,
                        isLast: true,
                        joinUserCount: 10
                    )
                )
                
                ChatItemView(
                    author: .mock(),
                    type: .ai,
                    config: .init(
                        message: .mock(),
                        isFirst: true,
                        isLast: false,
                        joinUserCount: 10
                    )
                )
                ChatItemView(
                    author: .mock(),
                    type: .ai,
                    config: .init(
                        message: .mock(),
                        isFirst: false,
                        isLast: true,
                        joinUserCount: 10
                    )
                )
            }
        }
    }
}
