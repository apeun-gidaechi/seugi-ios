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
    case people
    case notification
    case profile
    
    var text: String {
        switch self {
        case .home: "홈"
        case .chat: "채팅"
        case .people: "단체"
        case .notification: "알림"
        case .profile: "프로필"
        }
    }
    
    var image: Image {
        switch self {
        case .home: DesignSystemAsset.homeFill.swiftUIImage
        case .chat: DesignSystemAsset.chatFill.swiftUIImage
        case .people: DesignSystemAsset.peopleFill.swiftUIImage
        case .notification: DesignSystemAsset.notificationFill.swiftUIImage
        case .profile: DesignSystemAsset.personFill.swiftUIImage
        }
    }
}
