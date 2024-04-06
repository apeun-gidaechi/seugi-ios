//
//  EmailSignUpView.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import BaseFeature

public struct EmailSignUpView: View {
    
    @ObservedObject private var vm = EmailSignUpViewModel()
    var navigateToSignIn: () -> Void
    
    public init(
        navigateToSignIn: @escaping () -> Void
    ) {
        self.navigateToSignIn = navigateToSignIn
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            
            SeugiTextFieldForm("이름을 입력해 주세요", text: $vm.name, label: "이름")
                .padding(.top, 16)
            SeugiTextFieldForm("이메일 입력해 주세요", text: $vm.email, label: "이메일")
            SeugiTextFieldForm("비밀번호 입력해 주세요", text: $vm.password, type: .password, label: "비밀번호")
            SeugiTextFieldForm("비밀번호를 다시 입력해 주세요", text: $vm.passwordCheck, type: .password, label: "비밀번호 확인")
            
            Spacer()
            Button {
                navigateToSignIn()
            } label: {
                Text("이미 계정이 있으신가요?")
                    .seugiColor(.primary(.p500))
                    .font(.seugi(.body1))
            }
            SeugiButton.large("계속하기", type: .primary) {
                // handle sign up
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("회원가입")
    }
}
