//
//  ChatItemViewCell.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct ChatItemViewCell: View {
    
    private var text: String
    private var type: ChatItemViewCellType
    
    public init(text: String,
                type: ChatItemViewCellType) {
        self.text = text
        self.type = type
    }
    
    public var body: some View {
        Text(text)
            .font(.body(.b1))
            .seugiColor(type.foregroundColor)
            .padding(12)
            .background(Color.seugi(type.backgroundColor))
            .cornerRadius(8, corners: type.corners)
            .shadow(.ev(.ev1))
    }
}
