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
    
    init(
        messages: [Message],
        currentIndex: Int,
        room: Room
    ) {
        self.messages = messages
        self.currentIndex = currentIndex
        self.room = room
    }
    
    private var message: Message {
        messages[currentIndex]
    }
    
    var body: some View {
        switch message.viewType {
        case .text:
            if let member = appState.profile.data?.member {
                let author = room.findUserOrUnknownUser(id: message.userId)
                let type: ChatItemViewCellType = if author.id == member.id {
                    .me
                } else {
                    .other(
                        isFirst: messages.isFirstMessage(at: currentIndex),
                        isLast: messages.isLastMessage(at: currentIndex)
                    )
                }
                ChatItemView(author: author, message: message, type: type, joinedUserCount: room.joinUserId.count)
            }
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
