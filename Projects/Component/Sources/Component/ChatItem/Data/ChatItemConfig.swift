//
//  ChatItemConfig.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Domain

public struct ChatItemConfig {
    public let message: Message
    public let isFirst: Bool
    public let isLast: Bool
    public let joinUserCount: Int
    
    public init(message: Message, isFirst: Bool, isLast: Bool, joinUserCount: Int) {
        self.message = message
        self.isFirst = isFirst
        self.isLast = isLast
        self.joinUserCount = joinUserCount
    }
}
