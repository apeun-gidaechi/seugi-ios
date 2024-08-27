//
//  SeugiTextFieldForm.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiTextFieldForm: View {
    
    private let hint: String
    @Binding private var text: String
    private let type: SeugiTextFieldType
    private let label: String
    private let isForcedLabel: Bool
    
    public init(
        _ hint: String,
        text: Binding<String>,
        type: SeugiTextFieldType = .none(hasXMark: true),
        label: String,
        isForcedLabel: Bool = true
    ) {
        self.hint = hint
        self._text = text
        self.type = type
        self.label = label
        self.isForcedLabel = isForcedLabel
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
            SeugiTextField(hint, text: $text, type: type)
        }
    }
}
