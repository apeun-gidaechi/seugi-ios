//
//  ChatItemTimeLabelView.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

struct ChatItemTimeLabelView: View {
    let alignment: ChatItemHorizontalAlignment
    let config: ChatItemConfig
    
    var body: some View {
        if config.isLast {
            VStack(alignment: alignment.rawValue, spacing: 0) {
                let unreadUserCount = config.joinUserCount - config.message.read.count
                if unreadUserCount > 0 {
                    Text("\(unreadUserCount)")
                        .seugiColor(.gray(.g600))
                        .font(.caption(.c1))
                }
                Text(config.message.timestamp?.adjustedString ?? "")
                    .seugiColor(.gray(.g600))
                    .font(.caption(.c2))
            }
        }
    }
}
