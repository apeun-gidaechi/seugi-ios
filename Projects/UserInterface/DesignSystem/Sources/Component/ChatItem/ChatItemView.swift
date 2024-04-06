//
//  ChatItemView.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct ChatItemView: View {
    
    var author: String
    var type: ChatItemViewCellType
    
    public init(author: String, 
                type: ChatItemViewCellType) {
        self.author = author
        self.type = type
    }
    
    public var body: some View {
        HStack {
            if case .me = type {
                Spacer()
            }
            HStack(alignment: .top) {
                if case .other = type {
                    SeugiAvatar(type: .medium)
                }
                VStack(alignment: .leading, spacing: 4) {
                    if case .other = type {
                        Text(author)
                            .font(.seugi(.body1))
                            .seugiColor(.gray(.g600))
                    }
                    VStack(alignment: type == .other ? .leading : .trailing, spacing: 8) {
                        ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                        ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                        // 마지막 뷰 일때
                        HStack(alignment: .bottom) {
                            if case .other = type {
                                ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                            }
                            VStack(alignment: type == .other ? .leading : .trailing, spacing: 0) {
                                Text("1")
                                    .seugiColor(.gray(.g600))
                                    .font(.seugi(.caption1))
                                Text("오후 7:44")
                                    .seugiColor(.gray(.g600))
                                    .font(.seugi(.caption2))
                            }
                            if case .me = type {
                                ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                            }
                        }
                    }
                }
            }
            .padding()
            if case .other = type {
                Spacer()
            }
        }
    }
}
