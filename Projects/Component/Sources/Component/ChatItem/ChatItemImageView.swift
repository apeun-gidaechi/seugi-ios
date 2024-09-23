//
//  ChatItemImageView.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import Nuke
import NukeUI
import Domain

public struct ChatItemImageView: View {
    
    private let author: RetrieveMember
    private let type: ChatItemViewCellType
    private let config: ChatItemConfig
    
    public init(author: RetrieveMember, type: ChatItemViewCellType, config: ChatItemConfig) {
        self.author = author
        self.type = type
        self.config = config
    }
    
    private var imageUrl: String {
        config.message.message.split(separator: MessageConstant.fileSeparator).first.map(String.init) ?? ""
    }
    
    public var body: some View {
        ChatItemContainer(
            author: author,
            type: type,
            config: config
        ) {
            LazyImage(url: URL(string: imageUrl) ?? .aboutBlank) { state in
                if state.isLoading {
                    ProgressView()
                } else if let image = state.image {
                    image
                        .resizable()
                }
            }
            .frame(minWidth: 128, maxWidth: 320)
        }
    }
}
