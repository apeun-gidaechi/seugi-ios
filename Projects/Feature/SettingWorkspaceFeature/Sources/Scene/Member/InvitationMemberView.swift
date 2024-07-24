//
//  InvitationMemberView.swift
//  SettingWorkspaceFeature
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component
import BaseFeatureInterface

struct InvitationMemberView: View {
    
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = InvitationMemberViewModel()
    
    @State private var buttonsSize: CGSize = .zero
    @State private var showWorkspaceCodeDialog = false
    
    init() {}
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("학교코드로 멤버를 코대할 수 있어요")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                            .toLeading()
                        SeugiButton.small("학교코드 확인", type: .gray) {
                            if viewModel.workspaceCode.isSuccess {
                                showWorkspaceCodeDialog = true
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    VStack(spacing: 12) {
                        Group {
                            Text("\(3)명으로부터 가입 요청이 왔어요")
                                .font(.subtitle(.s2))
                                .seugiColor(.sub(.black))
                                .toLeading()
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
            .bottomGradientMask()
            GeometryReader { proxy in
                HStack(spacing: 8) {
                    SeugiButton.large("거절", type: .red) {
                    }
                    .disabled(true)
                    .frame(width: proxy.size.width * 0.33)
                    SeugiButton.large("수락", type: .primary) {
                    }
                    .disabled(true)
                    .frame(width: proxy.size.width * 0.67)
                }
                .onReadSize {
                    buttonsSize = $0
                }
            }
            .frame(height: buttonsSize.height)
            .toBottom()
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("멤버 초대")
        .alertWithAnyView("초대코드는 \(viewModel.workspaceCode.data ?? "")입니다", when: $showWorkspaceCodeDialog) { 
            Button("닫기") {}
        }
        .onAppear {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.fetchWaitMembers(workspaceId: selectedWorkspace.workspaceId)
            viewModel.fetchWorkspaceCode(workspaceId: selectedWorkspace.workspaceId)
        }
    }
}
