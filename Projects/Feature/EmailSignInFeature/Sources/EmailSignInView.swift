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
    @EnvironmentObject private var navController: NavigationController
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $vm.email, label: "이메일", isForcedLabel: true)
                .padding(.top, 16)
            SeugiTextFieldForm("비밀번호를 입력해주세요", text: $vm.password, type: .password, label: "비밀번호", isForcedLabel: true)
            Spacer()
            HStack(spacing: 0) {
                Text("계정이 없으시다면?")
                    .font(.seugi(.body1))
                    .seugiForeground(.gray(.g600))
                Button {
                    navController.path.append(.selectingJob)
                } label: {
                    Text("가입하기")
                        .font(.seugi(.body1))
                        .seugiForeground(.primary(.p500))
                }
            }
            SeugiButton("로그인", type: .primary) {
                // TODO:
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiToolbar("로그인") {
            dismiss()
        }
    }
}
