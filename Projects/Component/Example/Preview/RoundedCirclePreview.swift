//
//  RoundedCirclePreview.swift
//  DesignSystemExample
//
//  Created by dgsw8th71 on 3/29/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

public struct RoundedCirclePreview: View {
    
    public var body: some View {
        ScrollView {
            VStack {
                SeugiRoundedCircleImage.large(type: .image(.chicken))
                SeugiRoundedCircleImage.small(type: .image(.taco))
                SeugiRoundedCircleAsyncImage.large(url: "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg")
                SeugiRoundedCircleAsyncImage.small(url: "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg")
            }
        }
    }
}
