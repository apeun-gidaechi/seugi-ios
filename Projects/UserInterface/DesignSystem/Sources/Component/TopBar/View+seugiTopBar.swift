//
//  SeugiTopbar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension View {
    
    func seugiToolbar<TrailingContent>(
        _ title: String,
        showShadow: Bool = false,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent = { EmptyView() },
        backButtonTapped: (() -> Void)? = nil
    ) -> some View where TrailingContent: View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if let backButtonTapped {
                    Button {
                        backButtonTapped()
                    } label: {
                        DesignSystemAsset.arrowLeftLine.swiftUIImage
                            .resizable()
                            .renderingMode(.template)
                            .seugiForeground(.sub(.black))
                            .frame(width: 28, height: 28)
                    }
                }
                
                Text(title)
                    .font(.seugi(.subtitle1))
                    .seugiForeground(.sub(.black))
                    .if(backButtonTapped != nil) {
                        $0.padding(.leading, 16)
                    }
                
                Spacer()
                
                trailingContent()
            }
            .frame(height: 54)
            .padding(.horizontal, 16)
            .background(Color.seugi(.sub(.white)))
            
            self
                .navigationBarBackButtonHidden()
        }
        .if(showShadow) {
            $0.shadow(.ev(.ev1))
        }
    }
    
    func seugiToolbar(
        _ title: String,
        showShadow: Bool = false,
        icon1: Image? = nil,
        icon1ButtonTapped: (() -> Void)? = nil,
        icon2: Image? = nil,
        icon2ButtonTapped: (() -> Void)? = nil,
        backButtonTapped: (() -> Void)? = nil
    ) -> some View {
        self.seugiToolbar(
            title,
            showShadow: showShadow,
            trailingContent: {
                HStack(spacing: 16) {
                    if let icon1ButtonTapped,
                       let icon1 {
                        Button {
                            icon1ButtonTapped()
                        } label: {
                            icon1
                                .resizable()
                                .renderingMode(.template)
                                .seugiForeground(.sub(.black))
                                .frame(width: 28, height: 28)
                        }
                    }
                    if let icon2ButtonTapped,
                       let icon2 {
                        Button {
                            icon2ButtonTapped()
                        } label: {
                            icon2
                                .resizable()
                                .renderingMode(.template)
                                .seugiForeground(.sub(.black))
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            },
            backButtonTapped: backButtonTapped
        )
    }
}
