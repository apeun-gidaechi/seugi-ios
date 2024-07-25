//
//  SeugiSegmentedButton.swift
//  Component
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIUtil
import Combine

public protocol SegmentedButtonProtocol: Equatable {
    var label: String { get }
}

public struct SeugiSegmentedButton<T: SegmentedButtonProtocol>: View {
    
    private let data: [T]
    @Namespace private var animation
    @State private var selection: Binding<T>
    @State private var selected: T
    @State private var animatedSelection: T
    
    public init(
        _ data: [T],
        selection: Binding<T>
    ) {
        self.data = data
        self.selection = selection
        let selected = selection.wrappedValue
        self.selected = selected
        self.animatedSelection = selected
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(data, id: \.label) { item in
                let isSelected = animatedSelection == item
                Text(item.label)
                    .font(isSelected ? .body(.b1) : .body(.b2))
                    .seugiColor(isSelected ? .gray(.g800) : .gray(.g600))
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.seugi(.sub(.white)))
                                .matchedGeometryEffect(id: "background", in: animation)
                                .shadow(.evBlack(.ev1))
                        } else {
                            Color.seugi(.gray(.g100))
                        }
                    }
                    .button {
                        if selected != item {
                            selected = item
                        }
                    }
                    .applyAnimation()
                    .if(isSelected) {
                        $0.zIndex(1)
                    }
            }
        }
        .padding(4)
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .seugiBackground(.gray(.g100))
        .cornerRadius(12)
        .onChange(of: selected) { newValue in
            selection.wrappedValue = newValue
            withAnimation(.spring(duration: 0.2)) {
                animatedSelection = newValue
            }
        }
        .onReceive(Just(selection)) { newValue in
            withAnimation(.spring(duration: 0.2)) {
                selected = newValue.wrappedValue
            }
        }
    }
}
