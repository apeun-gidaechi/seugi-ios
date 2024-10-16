//
//  ManageMemberView.swift
//  SettingWorkspaceFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component
import Domain

struct WorkspaceMemberView: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    @StateObject private var viewModel = WorkspaceMemberViewModel()
    
    @State private var isSheetPresent: Bool = false
    @State private var sheetSize: CGSize = .zero
    
    private var members: Flow<[RetrieveProfile]> {
        viewModel.isSearching ? viewModel.searchedMembers : viewModel.selectedMembers
    }
    
    init() {}
    
    var body: some View {
        VStack(spacing: 12) {
            SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                .padding(.top, 6)
                .padding(.horizontal, 20)
            members.makeView {
                ProgressView()
            } success: { members in
                if let selectedWorkspace = mainViewModel.selectedWorkspace {
                    if members.isEmpty {
                        SeugiError("멤버가 없어요", image: .faceWithDiagonalMouth)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(members, id: \.member.id) { member in
                                    SeugiMemberList(type: .normal(member: member.member, role: .getRole(memberId: member.member.id, workspace: selectedWorkspace))) {
                                        Menu {
                                            Button("부관리자 임명") {}
                                            Button("학생 정보 수정") {
                                                isSheetPresent = true
                                            }
                                            Button("내보내기", role: .destructive) {}
                                        } label: {
                                            Image(icon: .detailVerticalLine)
                                                .resizable()
                                                .renderingMode(.template)
                                                .frame(width: 24, height: 24)
                                                .seugiColor(.gray(.g800))
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                        .scrollIndicators(.hidden)
                    }
                } else {
                    ProgressView()
                }
            } failure: { _ in
                SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
            }
            Spacer()
        }
        .seugiTopBar(title: "멤버")
        .searchable("채팅방 검색", text: $viewModel.searchText, isSearching: $viewModel.isSearching)
        .sheet(isPresented: $isSheetPresent) {
            VStack(spacing: 16) {
                Text("학생 정보 수정")
                    .font(.subtitle(.s1))
                    .seugiColor(.sub(.black))
                    .toLeading()
                    .padding(.leading, 4)
                VStack(spacing: 8) {
                    VStack(spacing: 4) {
                        Text("학년")
                            .toLeading()
                            .padding(.leading, 4)
                    }
                }
                SeugiButton.large("수정", type: .primary) {
                    // TODO: Handle to edit
                }
            }
            .padding(20)
            .onReadSize {
                sheetSize = $0
            }
            .presentationDetents([.height(sheetSize.height)])
        }
        .onAppear {
            guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                return
            }
            viewModel.fetchMembers(workspaceId: selectedWorkspace.workspaceId)
        }
    }
}
