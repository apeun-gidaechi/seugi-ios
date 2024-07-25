//
//  View+adjustedHeight.swift
//  SwiftUIUtil
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

struct AdjustedHeightSheetViewModifier: ViewModifier {
    
    @State private var size: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .onReadSize {
                self.size = $0
            }
            .presentationDetents([.height(size.height)])
    }
}

public extension View {
    func adjustedHeightSheet() -> some View {
        self.modifier(AdjustedHeightSheetViewModifier())
    }
}
