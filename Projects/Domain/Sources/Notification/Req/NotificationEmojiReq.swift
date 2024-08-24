//
//  NotificationEmojiReq.swift
//  Network
//
//  Created by hhhello0507 on 7/29/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct NotificationEmojiReq: Encodable {
    public let emoji: String
    public let notificationId: Int
}
