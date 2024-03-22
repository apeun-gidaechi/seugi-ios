//
//  AlimoSmallButton.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

struct SeugiSmallButton: View {
    
    var text: String
    var buttonType: SeugiButtonType
    var callback: () -> Void
    
    init(_ text: String,
         buttonType: SeugiButtonType = .primary,
         callback: @escaping () -> Void) {
        self.text = text
        self.buttonType = buttonType
        self.callback = callback
    }
    
    var body: some View {
        Button {
            callback()
        } label: {
            Text(text)
                .font(.seugi(.body2))
                .frame(height: 30)
                .padding(.horizontal, 12)
                .foregroundStyle(buttonType.foregroundColor)
                .background(buttonType.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
