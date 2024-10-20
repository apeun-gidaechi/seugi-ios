import SwiftUI
import Component
import Domain

struct WorkspaceMemberView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @StateObject private var viewModel = WorkspaceMemberViewModel()
    
    @State private var selectedEditProfile: RetrieveProfile?
    @State private var selectedProfile: RetrieveProfile?
    
    init() {}
}

extension WorkspaceMemberView: View {
    var body: some View {
        VStack(spacing: 12) {
            SeugiSegmentedButton(segmentedButtonRoles, selection: $viewModel.selection)
                .padding(.top, 6)
                .padding(.horizontal, 20)
            viewModel.mergedMembers.makeView {
                ProgressView()
            } success: { members in
                if mainViewModel.selectedWorkspace != nil {
                    if members.isEmpty {
                        SeugiError("멤버가 없어요", image: .faceWithDiagonalMouth)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(members, id: \.member.id) { member in
                                    Button {
                                        self.selectedProfile = member
                                    } label: {
                                        SeugiMemberList(
                                            type: .normal(
                                                member: member.member,
                                                role: member.permission
                                            )
                                        ) {
                                            Menu {
                                                Button("부관리자 임명") {}
                                                Button("학생 정보 수정") {
                                                    self.selectedEditProfile = member
                                                }
                                                Button("내보내기", role: .destructive) {}
                                            } label: {
                                                Image(icon: .detailVerticalLine)
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .frame(width: 24, height: 24)
                                                    .seugiColor(.gray(.g800))
                                            }
                                            .onTapGesture {} // for stop propagation
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
        .ignoresSafeArea()
        .seugiTopBar(title: "멤버")
        .searchable("채팅방 검색", text: $viewModel.searchText, isSearching: $viewModel.isSearching)
        .sheet(item: $selectedEditProfile, content: editProfileSheetContent)
        .sheet(item: $selectedProfile, content: profileSheetContent)
        .onAppear {
            guard let selectedWorkspace = mainViewModel.selectedWorkspace else { return }
            viewModel.fetchMembers(workspaceId: selectedWorkspace.workspaceId)
        }
        .onReceive(viewModel.$createdRoom) {
            if case .success(let room) = $0 {
                router.replace([MainDestination.chatDetail(room: room)])
            }
        }
    }
}

extension WorkspaceMemberView {
    @ViewBuilder
    private func editProfileSheetContent(profile: RetrieveProfile) -> some View {
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
        .adjustedHeightSheet()
    }
    
    @ViewBuilder
    private func profileSheetContent(profile: RetrieveProfile) -> some View {
        ProfileSheetView(profile: profile) {
            guard let member = mainViewModel.profile.data else { return }
            viewModel.createPersonalChat(
                workspaceId: member.workspaceId,
                memberId: member.member.id,
                anotherMemberId: profile.member.id
            )
            self.selectedProfile = nil
        }
        .adjustedHeightSheet()
    }
}
