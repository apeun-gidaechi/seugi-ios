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

public struct ChatItemImageView: View {
    
    private let config: ChatItemConfig
    
    public init(config: ChatItemConfig) {
        self.config = config
    }
    
    private var imageUrl: String {
        config.message.message.split(separator: MessageConstant.fileSeparator).first.map(String.init) ?? ""
    }
    
    public var body: some View {
        LazyImage(url: URL(string: imageUrl) ?? .aboutBlank) { state in
            if state.isLoading {
                ProgressView()
            } else if let image = state.image {
                image
                    .resizable()
            }
        }
        .frame(minWidth: 128, maxWidth: 320)
        .padding(.top, 8)
    }
}
