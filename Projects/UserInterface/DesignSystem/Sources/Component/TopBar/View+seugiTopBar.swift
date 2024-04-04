//
//  SeugiTopbar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension View {
    
    func seugiToolbar(
        _ title: String,
        icon1: Image? = nil,
        icon1ButtonTapped: (() -> Void)? = nil,
        icon2: Image? = nil,
        icon2ButtonTapped: (() -> Void)? = nil,
        backButtonTapped: (() -> Void)? = nil
    ) -> some View {
            VStack {
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
                        .padding(.leading, 16)
                    
                    Spacer()
                    
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
                        .padding(.trailing, 16)
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
                .frame(height: 54)
                .padding(.horizontal, 16)
                .background(Color.seugi(.sub(.white)))
                
                self
                    .navigationBarBackButtonHidden()
            }
        }
}
