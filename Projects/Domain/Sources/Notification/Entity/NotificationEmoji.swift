//
//  NotificationEmoji.swift
//  Domain
//
//  Created by hhhello0507 on 7/29/24.
//

import SwiftBok

@Init()
@Members()
public struct NotificationEmoji: Entity {
    public let emoji: String
    public let userId: Int
}
