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
import BaseFeatureInterface

private struct ManageMemberData: SegmentedButtonProtocol {
    var label: String
}

private let data: [ManageMemberData] = [
    .init(label: "선생님"),
    .init(label: "학생")
]

struct ManageMemberView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = ManageMemberViewModel()
    
    @State private var selection = data[0]
    @State private var isSheetPresent = false
    @State private var sheetSize: CGSize = .zero
    @State private var isSearching = false
    @FocusState private var searchFocus: Bool
    
    init() {}
    
    var body: some View {
        VStack(spacing: 12) {
            SeugiSegmentedButton(data, selection: $selection)
                .padding(.top, 6)
                .padding(.horizontal, 20)
            viewModel.members.makeView {
                ProgressView()
            } success: { members in
                if let selectedWorkspace = appState.selectedWorkspace {
                    let members = isSearching ? viewModel.searchedMembers : members
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
                } else {
                    ProgressView()
                }
            } failure: { _ in
                SeugiError("불러올 수 없어요", image: .faceWithDiagonalMouth)
            }
            Spacer()
        }
        .seugiTopBar("멤버 관리") {
            withAnimation {
                isSearching = false
            }
            if !isSearching {
                dismiss()
            }
        }
        .hideTitle(isSearching)
        .subView {
            if isSearching {
                TextField("채팅방 검색", text: $viewModel.searchText)
                    .focused($searchFocus)
            }
        }
        .if(!isSearching) { view in
            view.button(.searchLine) {
                withAnimation {
                    isSearching = true
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
