//
//  NotificationEmojiReq.swift
//  Network
//
//  Created by hhhello0507 on 7/29/24.
//

import Foundation

struct NotificationEmojiReq: Encodable {
    let emoji: String
    let notificationId: Int
}
