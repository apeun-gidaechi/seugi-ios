import SwiftUI
import BaseFeatureInterface
import Component
import Flow
import SwiftUIUtil

public struct FirstCreateRoomView: View {
    
    @EnvironmentObject private var router: Router
    @State private var contentSize: CGSize = .zero
    @EnvironmentObject private var vm: CreateRoomViewModel
    @EnvironmentObject private var appState: AppState
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            selectMember()
            vm.members.makeView {
                Spacer()
                ProgressView()
                Spacer()
            } success: { members in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(members, id: \.member.id) { member in
                            let selected = vm.selectedMembers.contains {
                                $0.member.id == member.member.id
                            }
                            SeugiMemberList(member: member) {
                                SeugiToggle(isOn: .constant(selected), type: .checkbox(size: .large))
                                    .disabled(true)
                            }
                            .button {
                                vm.selectMember(member: member, selected: selected)
                            }
                            .applyAnimation()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                Spacer()
            } failure: { _ in
                Text("불러오기 실패")
                    .font(.body(.b1))
            }
        }
        .onAppear {
            if let selectedWorkspace = appState.selectedWorkspace {
                vm.fetchWorkspaceMembers(workspaceId: selectedWorkspace.workspaceId)
            }
        }
        .seugiTopBar("멤버 선택")
        .subView {
            SeugiButton.small("완료", type: .transparent) {
                if vm.selectedMembers.count > 1 {
                    router.navigate(to: CreateRoomDestination.secondCreateRoom)
                } else {
//                    
                }
            }
            .disabled(vm.selectedMembers.isEmpty)
        }
    }
    
    @ViewBuilder
    private func selectMember() -> some View {
        HStack {
            if vm.selectedMembers.isEmpty {
                Text("멤버를 선택해 주세요")
                    .font(.body(.b2))
                    .seugiColor(.gray(.g500))
                    .padding(.leading, 8)
            } else {
                HFlow(itemSpacing: 4, rowSpacing: 4) {
                    ForEach(vm.selectedMembers, id: \.member.id) { member in
                        SeugiSelectingMember(member: member) {
                            vm.removeMember(member: member)
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
            if vm.selectedMembers.count > 1 {
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
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .seugiBackground(.sub(.white))
    }
}
