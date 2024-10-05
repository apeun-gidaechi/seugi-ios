import SwiftUI
import Component
import Flow
import SwiftUIUtil
import Domain

struct FirstCreateGroupChatView {
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var viewModel: CreateGroupChatViewModel
    
    @State private var contentSize: CGSize = .zero
    
    public init() {}
    
    private var profile: RetrieveProfile? {
        appState.profile.data
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
                                SeugiMemberList(type: .normal(member: member.member)) {
                                    SeugiToggle(isOn: .constant(selected), type: .checkbox(size: .large))
                                        .disabled(true)
                                }
                                .button {
                                    viewModel.selectMember(member: member, selected: selected)
                                }
                                .applyAnimation()
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
        .onAppear {
            guard let selectedWorkspace = appState.selectedWorkspace,
                  let member = appState.profile.data?.member else {
                return
            }
            viewModel.fetchWorkspaceMembers(workspaceId: selectedWorkspace.workspaceId, memberId: member.id)
//            viewModel.subscribe { subject in
//                switch subject {
//                case .createdPersonalChat(let room):
//                    router.navigateToRoot()
//                    router.navigate(to: MainDestination.chatDetail(room: room))
//                }
//            }
        }
        .seugiTopBar(
            title: "멤버 선택",
            subView: {
                SeugiButton.small("완료", type: .transparent) {
                    if viewModel.selectedMembers.count > 1 {
                        router.navigate(to: MainDestination.secondCreateGroupChat)
                    } else {
                        guard let selectedWorkspace = appState.selectedWorkspace else {
                            return
                        }
                        viewModel.createPersonalChat(workspaceId: selectedWorkspace.workspaceId)
                    }
                }
                .disabled(viewModel.selectedMembers.isEmpty)
            }
        )
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
                    ForEach(viewModel.selectedMembers, id: \.member.id) { member in
                        SeugiSelectingMember(member: member) {
                            viewModel.removeMember(member: member)
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
