//
//  ManageMemberView.swift
//  SettingWorkspaceFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component
import BaseFeatureInterface

struct ManageMemberView: View {
    
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = ManageMemberViewModel()
    
    init() {}
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SeugiTextField("멤버 검색", text: $viewModel.memberSearchText)
                    .padding(.top, 6)
                    .padding(.horizontal, 20)
                viewModel.members.makeView {
                    ProgressView()
                } success: { members in
                    if let selectedWorkspace = appState.selectedWorkspace {
                        LazyVStack(spacing: 0) {
                            ForEach(members, id: \.member.id) { member in
                                SeugiMemberList(type: .normal(member: member.member, role: .getRole(memberId: member.member.id, workspace: selectedWorkspace)))
                            }
                        }
                    }
                } failure: { _ in
                    SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
                }
            }
        }
        .scrollIndicators(.hidden)
        .seugiTopBar("멤버 관리")
        .onAppear {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.fetchMembers(workspaceId: selectedWorkspace.workspaceId)
        }
    }
}
