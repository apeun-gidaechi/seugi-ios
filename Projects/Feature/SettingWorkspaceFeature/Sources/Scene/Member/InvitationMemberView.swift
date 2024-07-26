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
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = InvitationMemberViewModel()
    
    @State private var buttonsSize: CGSize = .zero
    @State private var showWorkspaceCodeDialog = false
    
    init() {}
    
    private func fetchAll() {
        guard let selectedWorkspace = appState.selectedWorkspace else {
            return
        }
        viewModel.fetchWaitMembers(workspaceId: selectedWorkspace.workspaceId)
        viewModel.fetchWorkspaceCode(workspaceId: selectedWorkspace.workspaceId)
    }
    
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
                                alertProvider.present("초대코드는 \(viewModel.workspaceCode.data ?? "")입니다")
                                    .show()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    viewModel.waitMembers.makeView {
                        ProgressView()
                    } success: { members in
                        VStack(spacing: 12) {
                            Group {
                                Text("\(members.count)명으로부터 가입 요청이 왔어요")
                                    .font(.subtitle(.s2))
                                    .seugiColor(.sub(.black))
                                    .toLeading()
                                SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                            }
                            .padding(.horizontal, 20)
                        }
                        LazyVStack(spacing: 0) {
                            ForEach(members, id: \.id) { member in
                                SeugiMemberList(type: .normal(member: member)) {
                                    let selected = viewModel.selectedMembers.contains(member)
                                    SeugiToggle(isOn: .constant(selected), type: .checkbox(size: .large))
                                }
                                .button {
                                    viewModel.selectMember(member: member)
                                }
                                .applyAnimation()
                            }
                        }
                        .padding(.horizontal, 4)
                    } failure: { _ in
                        SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .bottomGradientMask()
            .refreshable {
                fetchAll()
            }
            GeometryReader { proxy in
                HStack(spacing: 8) {
                    Group {
                        SeugiButton.large("거절", type: .red) {
                        }
                        .frame(width: proxy.size.width * 0.33)
                        SeugiButton.large("수락", type: .primary) {
                        }
                        .frame(width: proxy.size.width * 0.67)
                    }
                    .disabled(viewModel.selectedMembers.isEmpty)
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
        .onAppear {
            fetchAll()
        }
    }
}
