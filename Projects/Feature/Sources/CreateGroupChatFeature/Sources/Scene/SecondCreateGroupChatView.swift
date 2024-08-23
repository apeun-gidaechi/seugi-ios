import SwiftUI
import Component
import Domain

public struct SecondCreateGroupChatView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var alertProvider: AlertProvider
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
            SeugiButton.small("완료", type: .transparent, isLoading: viewModel.createFlow == .fetching) {
                if let selectedWorkspace = appState.selectedWorkspace {
                    viewModel.createGroupChat(workspaceId: selectedWorkspace.workspaceId)
                }
            }
            .disabled(viewModel.roomName.isEmpty)
        }
        .onChange(of: viewModel.createFlow) { _ in
            router.navigateToRoot()
        } failure: { _ in
            alertProvider.present("채팅방 만들기 실패")
                .primaryButton("확인") {}
                .show()
        }
    }
}
