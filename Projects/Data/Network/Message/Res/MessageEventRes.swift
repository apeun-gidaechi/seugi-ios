//
//  MessageEventRes.swift
//  Network
//
//  Created by hhhello0507 on 8/4/24.
//

import Domain

struct MessageEventRes: SeugiResponse {
    let type: String?
    let userId: Int?
    let eventList: [Int]
    let messageId: String?
    
    func toEntity() -> MessageEvent {
        MessageEvent(
            type: .init(rawValue: type ?? ""),
            userId: userId,
            eventList: eventList,
            messageId: messageId
        )
    }
}
