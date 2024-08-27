//
//  SeugiCodeTextField.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/3/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import SwiftUtil
import SwiftUIUtil

public struct SeugiCodeTextField: View {
    
    // MARK: - parameters
    @Binding private var text: String
    private let length: Int
    
    public init(
        text: Binding<String>,
        length: Int
    ) {
        self._text = text
        self.length = length
    }
    
    // MARK: - local state
    @FocusState private var isFocused: Bool
    
    // MARK: - View
    public var body: some View {
        ZStack {
            TextField("", text: $text)
                .labelsHidden()
                .textFieldStyle(SeugiCodeTextFieldStyle(isFocused: isFocused))
                .focused($isFocused)
                .autocorrectionDisabled()
            HStack {
                ForEach(0..<length, id: \.self) { idx in
                    let char = text.getOrNil(idx: idx) ?? ""
                    SeugiCodeCell(isFocused: text.count > idx, char: char)
                }
            }
        }
        .onChange(of: text) {
            if $0.count > length {
                text = text[0..<length]
            }
        }
    }
}

struct SeugiCodeTextFieldStyle: TextFieldStyle {
    
    @Environment(\.isEnabled) var isEnabled
    var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        configuration
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.seugi(.sub(.white)))
            .padding(.horizontal, 16)
            .accentColor(.seugi(.sub(.transparent)))
            .seugiColor(.sub(.transparent))
    }
}

struct SeugiCodeCell: View {
    
    @Environment(\.isEnabled) var isEnabled
    var isFocused: Bool
    
    var char: String
    
    var body: some View {
        
        let lineWidth = isFocused ? 1.5 : 1
        let strokeColor: Color = isFocused ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        
        Text(char)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.seugi(.sub(.white)))
            .padding(.horizontal, 16)
            .cornerRadius(12, corners: .allCorners)
            .font(.subtitle(.s2))
            .accentColor(.seugi(.primary(.p500)))
            .seugiColor(isEnabled ? .sub(.black) : .gray(.g400))
            .allowsHitTesting(false)
            .overlay(
                ZStack {
                    RoundedCornerShape(radius: 12)
                        .stroke(isEnabled ? strokeColor : .seugi(.gray(.g200)), lineWidth: lineWidth)
                }
            )
    }
}
