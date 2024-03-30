//
//  OAuthSignUpView.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import BaseFeature

public struct OAuthSignUpView: View {
    
    @ObservedObject private var vm = OAuthSignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            
            SeugiTextFieldForm("이름을 입력해 주세요", text: $vm.name, label: "이름")
                .padding(.top, 16)
            
            Spacer()
            Button {
                
            } label: {
                Text("이미 계정이 있으신가요?")
                    .seugiForeground(.primary(.p500))
                    .font(.seugi(.body1))
            }
            SeugiButton.large("계속하기", type: .primary) {
                // TODO: handle sign up
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiToolbar("회원가입") {
            dismiss()
        }
    }
}
