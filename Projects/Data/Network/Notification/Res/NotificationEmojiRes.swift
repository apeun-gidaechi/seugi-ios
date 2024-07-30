//
//  NotificationEmojiRes.swift
//  Network
//
//  Created by hhhello0507 on 7/29/24.
//

import Domain

struct NotificationEmojiRes: SeugiResponse {
    let emoji: String
    let userId: Int
    
    func toEntity() -> NotificationEmoji {
        NotificationEmoji(
            emoji: emoji,
            userId: userId
        )
    }
}
