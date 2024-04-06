//
//  BottomNavigationType.swift
//  App
//
//  Created by dgsw8th71 on 2/25/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

public enum SeugiBottomNavigationType: CaseIterable {
    case home
    case chat
    case room
    case notification
    case profile
    
    var text: String {
        switch self {
        case .home: "홈"
        case .chat: "채팅"
        case .room: "단체"
        case .notification: "알림"
        case .profile: "프로필"
        }
    }
    
    var image: SeugiIconography {
        switch self {
        case .home: .homeFill
        case .chat: .chatFill
        case .room: .peopleFill
        case .notification: .notificationFill
        case .profile: .personFill
        }
    }
}
