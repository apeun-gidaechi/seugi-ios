//
//  JoinSchoolView.swift
//  SchoolCodeFeature
//
//  Created by dgsw8th71 on 3/30/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct SchoolCodeView: View {
    
    @ObservedObject private var vm = JoinSchoolViewModel()
    
    private var navigateToJoinSuccess: () -> Void
    
    public init(
        navigateToJoinSuccess: @escaping () -> Void
    ) {
        self.navigateToJoinSuccess = navigateToJoinSuccess
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("초대코드를 입력해 주세요", text: $vm.code, label: "초대코드")
                .padding(.top, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                navigateToJoinSuccess()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .hideBackButton()
    }
}
