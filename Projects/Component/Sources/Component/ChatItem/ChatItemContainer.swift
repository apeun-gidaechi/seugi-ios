//
//  ChatItemContainer.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Domain

// ChatItemContainer
// - Has Avatar
// - Horizontal align
struct ChatItemContainer<C: View>: View {
    let author: RetrieveMember
    let type: ChatItemViewCellType
    let config: ChatItemConfig
    @ViewBuilder let content: () -> C
    
    var body: some View {
        HStack(alignment: .top) {
            if case .other = type, config.isFirst {
                SeugiAvatar(author.picture, type: .medium)
            } else if case .ai = type, config.isFirst {
                SeugiAppIcon(type: .medium)
            }
            VStack(alignment: type.alignent.rawValue, spacing: 4) {
                if type.alignent == .leading && config.isFirst {
                    Text(author.name)
                        .font(.body(.b1))
                        .seugiColor(.gray(.g600))
                }
                content()
                    .padding(.leading, !config.isFirst && type.alignent == .leading ? 40 : 0)
            }
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .init(horizontal: type.alignent.rawValue, vertical: .center))
    }
}
