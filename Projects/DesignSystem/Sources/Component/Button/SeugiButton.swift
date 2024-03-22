//
//  AlimoButton.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

struct SeugiButton: View {
    
    var text: String
    var buttonType: SeugiButtonType
    var isLoading: Bool
    var callback: () -> Void
    
    init(_ text: String, 
         buttonType: SeugiButtonType = .primary,
         isLoading: Bool = false,
         callback: @escaping () -> Void) {
        self.text = text
        self.buttonType = buttonType
        self.isLoading = isLoading
        self.callback = callback
    }
    
    var body: some View {
        Button {
            callback()
        } label: {
            Text(!isLoading ? text : "")
                .font(.body)
                .frame(maxWidth: .infinity, maxHeight: 54)
                .foregroundStyle(buttonType.foregroundColor)
                .background(buttonType.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
        .padding(.horizontal, 20)
        .disabled(isLoading)
    }
}
