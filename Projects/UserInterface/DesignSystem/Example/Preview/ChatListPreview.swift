//
//  ChatListPreview.swift
//  DesignSystemExample
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct ChatListPreview: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SeugiChatList()
                SeugiChatList()
                SeugiChatList()
            }
        }
    }
}
