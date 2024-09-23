//
//  SeugiTextFieldForm.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiCodeTextFieldForm: View {
    
    @Binding private var text: String
    private let label: String
    private let isForcedLabel: Bool
    private let length: Int
    
    public init(
        text: Binding<String>,
        label: String,
        isForcedLabel: Bool = true,
        length: Int
    ) {
        self._text = text
        self.label = label
        self.isForcedLabel = isForcedLabel
        self.length = length
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(label)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                if isForcedLabel {
                    Text("*")
                        .font(.subtitle(.s2))
                        .seugiColor(.red(.r500))
                }
            }
            .padding(.leading, 4)
            SeugiCodeTextField(text: $text, length: length)
        }
    }
}
