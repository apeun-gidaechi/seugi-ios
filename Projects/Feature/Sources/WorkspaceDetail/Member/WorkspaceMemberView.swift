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
    
    @Environment(\.dismiss) private var dismiss
    @AppState private var appState
    @State private var viewModel = WorkspaceMemberViewModel()
    
    @State private var isSheetPresent = false
    @State private var sheetSize: CGSize = .zero
    @FocusState private var searchFocus: Bool
    
    init() {}
    
    var body: some View {
        VStack(spacing: 12) {
            SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                .padding(.top, 6)
                .padding(.horizontal, 20)
            Menu {
                ForEach(viewModel.menus, id: \.self) { menu in
                    Button(menu) {
                        viewModel.selectedMenu = menu
                    }
                }
            } label: {
                Text(viewModel.selectedMenu ?? "전체")
            }
            viewModel.members.makeView {
                ProgressView()
            } success: { _ in
                if let selectedWorkspace = appState.selectedWorkspace {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.searchtedMembers, id: \.member.id) { member in
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
                } else {
                    ProgressView()
                }
            } failure: { _ in
                SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
            }
            Spacer()
        }
        .seugiTopBar("멤버") {
            withAnimation {
                viewModel.isSearching = false
            }
            if !viewModel.isSearching {
                dismiss()
            }
        }
        .hideTitle(viewModel.isSearching)
        .subView {
            if viewModel.isSearching {
                TextField("채팅방 검색", text: $viewModel.searchText)
                    .focused($searchFocus)
            }
        }
        .if(!viewModel.isSearching) { view in
            view.button(.searchLine) {
                withAnimation {
                    viewModel.isSearching = true
                    searchFocus = true
                }
            }
        }
        .onAppear {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.fetchMembers(workspaceId: selectedWorkspace.workspaceId)
        }
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
    }
}
