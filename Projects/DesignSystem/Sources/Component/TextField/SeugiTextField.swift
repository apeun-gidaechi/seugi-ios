//
//  AlimoTextField.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/4/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

struct SeugiTextField: View {
    
    // MARK: - parameters
    let hint: String
    @Binding var text: String
    let textFieldType: SeugiTextFieldType
    
    init(_ hint: String = "",
         text: Binding<String>,
         textFieldType: SeugiTextFieldType = .none(hasXMark: true)) {
        self.hint = hint
        self._text = text
        self.textFieldType = textFieldType
    }
    
    // MARK: - local state
    @FocusState private var isFocused: Bool
    @State private var isHide: Bool = true
    
    // MARK: - View
    var body: some View {
        
        let lineWidth = isFocused ? 1.5 : 1
        let strokeColor: Color = isFocused ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        
        Group {
            if textFieldType == .password && isHide {
                SecureField(hint,
                            text: $text)
            } else {
                TextField(hint,
                          text: $text)
            }
        }
        .autocorrectionDisabled()
        .focused($isFocused)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(Color.white)
        .padding(.horizontal, 16)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .font(.seugi(.body2))
        .accentColor(.seugi(.primary(.p500)))
        .foregroundStyle(.black)
        .overlay(
            ZStack {
                RoundedCorner(radius: 12)
                    .stroke(strokeColor, lineWidth: lineWidth)
                HStack(spacing: 0) {
                    Spacer()
                    
                    switch textFieldType {
                    case .none(let hasXMark):
                        if hasXMark && !text.isEmpty {
                            Image(DesignSystemAsset.closeFill.name)
                                .renderingMode(.template)
                                .seugiForeground(.gray(.g500))
                                .onTapGesture {
                                    text = ""
                                }
                        }
                    case .password:
                        Image(isHide ? DesignSystemAsset.hideFill.name : DesignSystemAsset.showFill.name)
                            .renderingMode(.template)
                            .seugiForeground(.gray(.g500))
                            .onTapGesture {
                                isHide.toggle()
                            }
                    }
                }
                .padding(.trailing, 16)
            }
        )
        .padding(.horizontal, 20)
    }
}
