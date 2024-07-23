import SwiftUI
import BaseFeatureInterface
import Component
import Domain

public struct SecondCreateGroupChatView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: CreateGroupChatViewModel
    @EnvironmentObject private var appState: AppState
    
    public init() {}
    
    private var firstMember: RetrieveProfile {
        viewModel.selectedMembers.first!
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                SeugiRoomImage(nil, type: .extraLarge, label: firstMember.member.name.getOrNil(idx: 0) ?? "-")
                Image(icon: .addFill)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g600))
            }
            VStack(spacing: 4) {
                Text("채팅방 이름")
                    .toLeading()
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .padding(.top, 6)
                    .padding(.leading, 4)
                SeugiTextField("\(firstMember.member.name) 외 \(viewModel.selectedMembers.count - 1)명", text: $viewModel.roomName)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .seugiTopBar("")
        .subView {
            SeugiButton.small("완료", type: .transparent, isLoading: viewModel.fetchCreate) {
                if let selectedWorkspace = appState.selectedWorkspace {
                    viewModel.createGroupChat(workspaceId: selectedWorkspace.workspaceId)
                }
            }
            .disabled(viewModel.roomName.isEmpty)
        }
        .alertWithAnyView("채팅방 만들기 실패", when: $viewModel.createFailure) {
            Button("확인") {}
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .createSuccess:
                    router.navigateToRoot()
                }
            }
        }
    }
}
