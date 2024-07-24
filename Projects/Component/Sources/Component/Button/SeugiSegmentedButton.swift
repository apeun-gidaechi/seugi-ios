//
//  SeugiSegmentedButton.swift
//  Component
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import SwiftUI

public protocol SegmentedButtonProtocol {
    var label: String { get }
}

public struct SeugiSegmentedButton<T: SegmentedButtonProtocol>: View {
    
    private let data: [T]
    @Binding private var selection: T
    @Namespace private var animation
    
    public init(
        data: [T],
        selection: Binding<T>
    ) {
        self.data = data
        self._selection = selection
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(data, id: \.label) { item in
                let selected = item.label == selection.label
                Text(item.label)
                    .font(selected ? .body(.b2) : .body(.b1))
                    .seugiColor(selected ? .gray(.g800) : .gray(.g500))
                    .if(selected) {
                        $0.background {
                            Color.seugi(.sub(.white))
                                .matchedGeometryEffect(id: "background", in: animation)
                        }
                    }
                    .button {
                        selection = item
                    }
            }
        }
        .padding(4)
        .frame(height: 44)
        .seugiBackground(.gray(.g100))
        .cornerRadius(12)
    }
}
