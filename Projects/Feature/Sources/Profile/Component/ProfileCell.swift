//
//  ProfileCell.swift
//  ProfileFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct ProfileCell: View {
    
    private let title: String
    private let value: String
    private let action: () -> Void
    
    init(
        _ title: String, 
        value: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.value = value
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.body(.b1))
                    .seugiColor(.gray(.g500))
                Spacer()
                Image(icon: .writeLine)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.gray(.g500))
                    .frame(width: 20, height: 20)
                    .button {
                        action()
                    }
                    .scaledButtonStyle()
            }
            .padding(.horizontal, 20)
            SeugiListItem.normal(title: value.isEmpty ? "-" : value)
            SeugiDivider()
                .padding(.horizontal, 24)
        }
    }
}
