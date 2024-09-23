//
//  Preview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

enum SeugiPreview: String, CaseIterable {
    case color = "Color"
    case font = "Font"
    case shadow = "Shadow"
    case button = "Button"
    case textField = "TextField"
    case menu = "Menu"
    case bottomNavigation = "BottomNavigation"
    case badge = "Badge"
    case divider = "Divider"
    case listItem = "ListItem"
    case avatar = "Avatar"
    case topBar = "TopBar"
    case category = "Category"
    case chatList = "ChatList"
    case memberList = "MemberList"
    case chatItem = "ChatItem"
    case roundedCircle = "RoundedCircle"
    case toolTip = "ToolTip"
    case roomImage = "RoomImage"
    case error = "Error"
    case alert = "Alert"
    
    var view: some View {
        Group {
            switch self {
            case .color: ColorPreview()
            case .font: FontPreview()
            case .shadow: ShadowPreview()
            case .button: ButtonPreview()
            case .textField: TextFieldPreview()
            case .menu: DropdownPreview()
            case .bottomNavigation: BottomNavigationPreview()
            case .badge: BadgePreview()
            case .divider: DividerPreview()
            case .listItem: ListItemPreview()
            case .avatar: AvatarPreview()
            case .topBar: TopBarPreview()
            case .category: CategoryPreview()
            case .chatList: ChatListPreview()
            case .memberList: MemberListPreview()
            case .chatItem: ChatItemPreview()
            case .roundedCircle: RoundedCirclePreview()
            case .toolTip: ToolTipPreview()
            case .roomImage: RoomImagePreview()
            case .error: ErrorPreview()
            case .alert: ModalPreview()
            @unknown default: SeugiError("페이지를 찾을 수 없습니다", image: .faceWithDiagonalMouth)
            }
        }
    }
    static var preview: some View {
        NavigationStack {
            let lst = Self.allCases.sorted { $0.rawValue < $1.rawValue }
            List(lst, id: \.self) { preview in
                NavigationLink {
                    preview.view
                } label: {
                    Text(preview.rawValue)
                }
            }
        }
//        SeugiPreview.alert.view
    }
}
