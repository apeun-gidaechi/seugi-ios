import SwiftUI
import Component
import Flow
import SwiftUIUtil
import Domain

struct FirstCreateGroupChatView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var viewModel: CreateGroupChatViewModel
    
    @State private var contentSize: CGSize = .zero
    
    private var profile: RetrieveProfile? {
        mainViewModel.profile.data
    }
}

extension FirstCreateGroupChatView: View {
    var body: some View {
        VStack(spacing: 0) {
            viewModel.members.makeView {
                Spacer()
                ProgressView()
                Spacer()
            } success: { members in
                if members.isEmpty {
                    SeugiError("멤버가 없어요", image: .sadButRelievedFace)
                } else {
                    selectMember()
                        .padding(.top, 6)
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            // 나를 제외한 모든 멤버 나타내기
                            ForEach(members.filter { $0.member.id != profile?.member.id }, id: \.member.id) { member in
                                let selected = viewModel.selectedMembers.contains {
                                    $0.member.id == member.member.id
                                }
                                Button {
                                    viewModel.selectMember(member: member, selected: selected)
                                } label: {
                                    SeugiMemberList(type: .normal(member: member.member)) {
                                        SeugiToggle(isOn: .constant(selected), type: .checkbox(size: .large))
                                            .disabled(true)
                                    }
                                }
                                .scaledButtonStyle()
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    .scrollIndicators(.hidden)
                }
                Spacer()
            } failure: { _ in
                SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
                    .toVertical()
            }
        }
        .seugiTopBar(
            title: "멤버 선택",
            subView: {
                SeugiButton.small(
                    "완료",
                    type: .transparent,
                    isLoading: viewModel.createRoomFlow.is(.fetching)
                ) {
                    guard let selectedWorkspace = mainViewModel.selectedWorkspace,
                          let member = mainViewModel.profile.data?.member else {
                        return
                    }
                    if viewModel.selectedMembers.count > 1 {
                        router.navigate(to: CreateGroupChatPath.secondCreateGroupChat)
                    } else {
                        viewModel.createPersonalChat(
                            workspaceId: selectedWorkspace.workspaceId,
                            memberId: member.id
                        )
                    }
                }
                .disabled(viewModel.selectedMembers.isEmpty)
            }
        )
        .onAppear {
            guard let selectedWorkspace = mainViewModel.selectedWorkspace,
                  let member = mainViewModel.profile.data?.member else {
                return
            }
            viewModel.fetchWorkspaceMembers(
                workspaceId: selectedWorkspace.workspaceId,
                memberId: member.id
            )
        }
        .onReceive(viewModel.$createdRoom) {
            if case .success(let room) = $0 {
                router.replace([MainDestination.chatDetail(room: room)])
            }
        }
    }
    
    @ViewBuilder
    private func selectMember() -> some View {
        HStack {
            if viewModel.selectedMembers.isEmpty {
                Text("멤버를 선택해 주세요")
                    .font(.body(.b2))
                    .seugiColor(.gray(.g500))
                    .padding(.leading, 8)
            } else {
                HFlow(itemSpacing: 4, rowSpacing: 4) {
                    ForEach(viewModel.selectedMembers, id: \.member.id) { profile in
                        SeugiSelectingMember(profile: profile) {
                            viewModel.removeMember(member: profile)
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .onReadSize { size in
            // count <= 1 일때 애니메이션 이상해서 조건으로 분기함
            if viewModel.selectedMembers.count > 1 {
                withAnimation {
                    contentSize = size
                }
            } else {
                contentSize = size
            }
        }
        .scrollOnOverflow(300)
        .frame(height: min(contentSize.height, 300))
        .frame(minHeight: 52)
        .stroke(12, content: Color.seugi(.gray(.g300)))
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
        .seugiBackground(.sub(.white))
    }
}
