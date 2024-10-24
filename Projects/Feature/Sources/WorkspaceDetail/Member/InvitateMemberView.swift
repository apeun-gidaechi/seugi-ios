//
//  InvitationMemberView.swift
//  SettingWorkspaceFeature
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct InvitateMemberView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var mainViewModel: MainViewModel
    @StateObject private var viewModel = InvitateMemberViewModel()
    
    @State private var buttonsSize: CGSize = .zero
    @State private var showWorkspaceCodeDialog: Bool = false
    
    init() {}
    
    private func fetchAll() {
        guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
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
                        Text("학교코드로 멤버를 초대할 수 있어요")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                            .toLeading()
                            .padding(.leading, 4)
                        SeugiButton.small("학교코드 확인", type: .gray) {
                            if case .success = viewModel.workspaceCode {
                                showWorkspaceCodeDialog = true
                                alertProvider.present(
                                    .init(title: "초대코드는 \(viewModel.workspaceCode.data ?? "")입니다")
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    if let workspaceRole = mainViewModel.workspaceRole,
                       workspaceRole >= .middleAdmin {
                        viewModel.waitMembers.makeView {
                            ProgressView()
                        } success: { members in
                            VStack(spacing: 12) {
                                Text("\(members.count)명으로부터 가입 요청이 왔어요")
                                    .font(.subtitle(.s2))
                                    .seugiColor(.sub(.black))
                                    .toLeading()
                                    .padding(.leading, 4)
                                SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                            }
                            .padding(.horizontal, 20)
                            LazyVStack(spacing: 0) {
                                ForEach(members, id: \.id) { member in
                                    SeugiMemberList(type: .normal(member: member)) {
                                        let selected = viewModel.selectedMembers.contains(member)
                                        SeugiToggle(isOn: .constant(selected), type: .checkbox(size: .large))
                                    }
                                    .button {
                                        viewModel.selectMember(member: member)
                                    }
                                    .scaledButtonStyle()
                                }
                            }
                            .padding(.horizontal, 4)
                        } failure: { _ in
                            SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .bottomGradientMask()
            .refreshable {
                fetchAll()
            }
            // MARK: - Bottom buttons
            GeometryReader { proxy in
                HStack(spacing: 8) {
                    Group {
                        SeugiButton.large("거절", type: .red) {
                            guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                                return
                            }
                            viewModel.addWorkspace(workspaceId: selectedWorkspace.workspaceId)
                        }
                        .frame(width: proxy.size.width * 0.33)
                        SeugiButton.large("수락", type: .primary, isLoading: viewModel.addWorkspaceFlow == .fetching) {
                            guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                                return
                            }
                            viewModel.addWorkspace(workspaceId: selectedWorkspace.workspaceId)
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
        .seugiTopBar(title: "멤버 초대")
        .onAppear {
            fetchAll()
        }
        // TODO: Resolve
//        .onReceive(viewModel.$waitMembers) {
//            if case .failure = $0 {
//                alertProvider.present("불러오기 실패")
//                    .show()
//            }
//        }
        .onReceive(viewModel.$addWorkspaceFlow) { flow in
            switch flow {
            case .success:
                alertProvider.present(
                    .init(title: "가입 수락 성공")
                )
                guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                    return
                }
                viewModel.fetchWaitMembers(workspaceId: selectedWorkspace.workspaceId)
            case .failure:
                alertProvider.present(
                    .init(title: "가입 수락 실패")
                    .primaryButton("확인")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
        .onReceive(viewModel.$cancelWorkspaceFlow) { flow in
            switch flow {
            case .success:
                alertProvider.present(
                    .init(title: "가입 거절 성공")
                )
                guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                    return
                }
                viewModel.fetchWaitMembers(workspaceId: selectedWorkspace.workspaceId)
            case .failure:
                alertProvider.present(
                    .init(title: "가입 거절 실패")
                    .primaryButton("확인")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
    }
}
