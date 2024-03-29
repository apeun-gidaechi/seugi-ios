//
//  SeugiChatTextField.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/29/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiChatTextField: View {
    
    var hint: String
    @Binding var text: String
    var addButtonTapped: () -> Void
    var sendButtonTapped: () -> Void
    
    public init(_ hint: String, 
                text: Binding<String>,
                addButtonTapped: @escaping () -> Void,
                sendButtonTapped: @escaping () -> Void) {
        self.hint = hint
        self._text = text
        self.addButtonTapped = addButtonTapped
        self.sendButtonTapped = sendButtonTapped
    }
    
    public var body: some View {
        HStack {
            Button {
                addButtonTapped()
            } label: {
                DesignSystemAsset.addFill.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .seugiForeground(.gray(.g400))
                    .frame(width: 32, height: 32)
            }
            TextField(hint, text: $text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .seugiForeground(.sub(.black))
                .tint(.seugi(.primary(.p500)))
            let sendButtonColor: Color.SeugiColorSystem = text.isEmpty ? .gray(.g400) : .primary(.p500)
            Button {
                sendButtonTapped()
            } label: {
                DesignSystemAsset.sendFill.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .seugiForeground(sendButtonColor)
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 56)
        .background(Color.seugi(.sub(.white)))
        .cornerRadius(12, corners: .allCorners)
        .shadow(.ev(.ev1))
    }
}