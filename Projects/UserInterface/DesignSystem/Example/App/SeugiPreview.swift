//
//  Preview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

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
            }
        }
    }
    static var preview: some View {
        NavigationStack {
            List(Self.allCases, id: \.self) { preview in
                NavigationLink {
                    preview.view
                    //                        .navigationTitle(preview.rawValue)
                } label: {
                    Text("\(preview.rawValue) Preview")
                }
            }
        }
    }
}
