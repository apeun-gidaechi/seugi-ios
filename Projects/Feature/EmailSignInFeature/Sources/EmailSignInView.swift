//
//  EmailSignInView.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import BaseFeature

public struct EmailSignInView: View {
    
    @ObservedObject private var vm = EmailSignInViewModel()
    var navigateToSignUp: () -> Void
    
    public init(
        navigateToSignUp: @escaping () -> Void
    ) {
        self.navigateToSignUp = navigateToSignUp
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $vm.email, label: "이메일", isForcedLabel: true)
                .padding(.top, 16)
            SeugiTextFieldForm("비밀번호를 입력해주세요", text: $vm.password, type: .password, label: "비밀번호", isForcedLabel: true)
            Spacer()
            HStack(spacing: 0) {
                Text("계정이 없으시다면?")
                    .font(.body(.b1))
                    .seugiColor(.gray(.g600))
                Button {
                    navigateToSignUp()
                } label: {
                    Text("가입하기")
                        .font(.body(.b1))
                        .seugiColor(.primary(.p500))
                }
            }
            SeugiButton.large("로그인", type: .primary) {
                // TODO:
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("로그인")
    }
}
