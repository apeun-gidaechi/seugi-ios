//
//  JoinSchoolView.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct JoinSchoolView: View {
    
    @EnvironmentObject private var navController: NavigationController
    @ObservedObject private var vm = JoinSchoolViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack {
            SeugiTextFieldForm("초대코드를 입력해 주세요", text: $vm.code, label: "초대코드")
                .padding(.top, 16)
            Spacer()
            SeugiButton("계속하기", type: .primary) {
                // TODO: handle join school
            }
            .padding(Edge.Set.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiToolbar("학교 가입")
    }
}
