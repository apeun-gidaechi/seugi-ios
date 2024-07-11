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
                ChatItemDateView(date: "2024년 3월 21일 목요일")
                // MARK: - Other
                ChatItemView(author: .mock(), message: .mock(), type: .other(isFirst: true, isLast: false), joinedUserCount: 100)
                ChatItemView(author: .mock(), message: .mock(), type: .other(isFirst: false, isLast: false), joinedUserCount: 100)
                ChatItemView(author: .mock(), message: .mock(), type: .other(isFirst: false, isLast: true), joinedUserCount: 100)
                
                // MARK: - Me
                ChatItemView(author: .mock(), message: .mock(), type: .me, joinedUserCount: 100)
                
                // MARK: - AI
                ChatItemView(author: .mock(), message: .mock(), type: .ai(isFirst: true, isLast: false), joinedUserCount: 100)
                ChatItemView(author: .mock(), message: .mock(), type: .ai(isFirst: false, isLast: false), joinedUserCount: 100)
                ChatItemView(author: .mock(), message: .mock(), type: .ai(isFirst: false, isLast: true), joinedUserCount: 100)
            }
        }
    }
}
