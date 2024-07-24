//
//  InvitationMemberView.swift
//  SettingWorkspaceFeature
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct InvitationMemberView: View {
    
    @ObservedObject private var viewModel = InvitationMemberViewModel()
    
    init() {}
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("학교코드로 멤버를 코대할 수 있어요")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    SeugiButton.small("학교코드 확인", type: .gray) {
                        // TODO: Show alert
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                VStack(spacing: 12) {
                    Group {
                        Text("\(3)명으로부터 가입 요청이 왔어요")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                    }
                    .padding(.horizontal, 20)
                }
//                LazyVStack() {
//                    
//                }
//                .padding(.horizontal, 4)
            }
        }
        .scrollIndicators(.hidden)
        .seugiTopBar("멤버 초대")
    }
}
