//
//  View+addTimeLabel.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

extension View {
    func addTimeLabel(alignment: ChatItemHorizontalAlignment, config: ChatItemConfig) -> some View {
        HStack(alignment: .bottom) {
            if alignment == .leading {
                self
            }
            ChatItemTimeLabelView(alignment: alignment, config: config)
            if alignment == .trailing {
                self
            }
        }
    }
}
