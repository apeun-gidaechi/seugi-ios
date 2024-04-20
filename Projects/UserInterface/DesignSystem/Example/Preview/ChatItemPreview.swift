//
//  ChatItemPreview.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct ChatItemPreview: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ChatItemDateView(date: "2024년 3월 21일 목요일")
                ChatItemView(author: "이강현", type: .other)
                ChatItemView(author: "이강현", type: .me)
                ChatItemView(author: "박재욱", type: .other)
                ChatItemView(author: "AI", type: .ai)
                ChatItemView(author: "AI", type: .ai)
            }
        }
    }
}
