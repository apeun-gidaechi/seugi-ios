//
//  ChatMessageCell.swift
//  Feature
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Domain
import Component

struct ChatMessageCell: View {
    
    @AppState private var appState
    
    private let messages: [Message]
    private let currentIndex: Int
    private let room: Room
    private let author: RetrieveMember
    private let message: Message
    private let config: ChatItemConfig
    
    init(
        messages: [Message],
        currentIndex: Int,
        room: Room
    ) {
        self.messages = messages
        self.currentIndex = currentIndex
        self.room = room
        self.message = messages[currentIndex]
        self.author = room.findUserOrUnknownUser(id: message.userId)
        self.config = ChatItemConfig(
            message: message,
            isFirst: messages.isFirstMessage(at: currentIndex),
            isLast: messages.isLastMessage(at: currentIndex),
            joinUserCount: room.joinUserId.count
        )
    }
    
    private var me: RetrieveMember? {
        appState.profile.data?.member
    }
    
    private var type: ChatItemViewCellType {
        author.id == me?.id ? .me : .other
    }
    
    var body: some View {
        switch message.viewType {
        case .text:
            ChatItemView(
                author: author,
                type: type,
                config: config
            )
        case .image:
            EmptyView()
        case .file:
            EmptyView()
        case .detail:
            if let text = message.getDetailText(room: room) {
                ChatItemDetailView(text: text)
            }
        default:
            EmptyView()
        }
    }
}
