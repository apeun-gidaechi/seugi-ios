//
//  ChatItemDateView.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct ChatItemDateView: View {
    
    var date: String
    
    public init(date: String) {
        self.date = date
    }
    
    public var body: some View {
        HStack {
            Spacer()
            Text(date)
                .font(.caption(.c2))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.seugi(.gray(.g100)))
                .cornerRadius(24, corners: .allCorners)
                .padding(.vertical, 12)
            Spacer()
        }
    }
}
