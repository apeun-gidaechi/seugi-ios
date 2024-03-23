//
//  SeugiTopbar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension View {
    func seugiToolbar(_ title: String,
                      backButtonTapped: @escaping () -> Void) -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 0) {
                        Button {
                            backButtonTapped()
                        } label: {
                            DesignSystemAsset.arrowLeftLine.swiftUIImage
                                .resizable()
                                .renderingMode(.template)
                                .seugiForeground(.sub(.black))
                                .frame(width: 28, height: 28)
                        }
                        
                        Text(title)
                            .font(.seugi(.subtitle1))
                            .seugiForeground(.sub(.black))
                            .padding(.leading, 8)
                    }
                    .frame(height: 44)
                }
            }
    }
}
