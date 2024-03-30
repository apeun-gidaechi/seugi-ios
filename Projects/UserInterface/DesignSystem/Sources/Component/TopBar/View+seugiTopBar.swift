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
                      backButtonTapped: (() -> Void)? = nil) -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
                            .padding(.leading, 8)
                    }
                    .frame(height: 44)
                }
            }
    }
    
    func seugiIcon(icon1: Image,
                   icon1ButtonTapped: @escaping (() -> Void),
                   icon2: Image? = nil,
                   icon2ButtonTapped: (() -> Void)? = nil) -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Button {
                            icon1ButtonTapped()
                        } label: {
                            icon1
                                .resizable()
                                .renderingMode(.template)
                                .seugiForeground(.sub(.black))
                                .frame(width: 28, height: 28)
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
                    .frame(height: 44)
                }
            }
    }
}
