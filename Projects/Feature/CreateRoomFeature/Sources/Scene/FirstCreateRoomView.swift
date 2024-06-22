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
                            }
                            .button {
                                if !selected {
                                    vm.selectedMembers.append(member)
                                } else {
                                    vm.selectedMembers = vm.selectedMembers.filter {
                                        $0.member.id != member.member.id
                                    }
                                }
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
                router.navigate(to: CreateRoomDestination.secondCreateRoom)
            }
        }
    }
    
    @ViewBuilder
    private func selectMember() -> some View {
        HStack {
            HFlow(itemSpacing: 4, rowSpacing: 4) {
                ForEach(vm.selectedMembers, id: \.member.id) { member in
                    SeugiSelectingMember(member: member) {}
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    contentSize = geo.size
                }
            }
        )
        .scrollOnOverflow(300)
        .frame(height: min(contentSize.height, 300))
        .frame(minHeight: 52)
        .stroke(12, content: Color.seugi(.gray(.g300)))
        .padding(.horizontal, 16)
    }
}
