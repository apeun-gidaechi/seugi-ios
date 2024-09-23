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
    
    private let imageUrl: String
    private let config: ChatItemConfig
    
    public init(imageUrl: String, config: ChatItemConfig) {
        self.imageUrl = imageUrl
        self.config = config
    }
    
    public var body: some View {
        LazyImage(url: URL(string: imageUrl) ?? .aboutBlank) { state in
            if state.isLoading {
                ProgressView()
            } else if let image = state.image {
                image
            }
        }
    }
}
