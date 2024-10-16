import SwiftUI
import Component
import Domain

struct SecondCreateGroupChatView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var viewModel: CreateGroupChatViewModel
    @EnvironmentObject private var mainViewModel: MainViewModel
}
    
extension SecondCreateGroupChatView: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                SeugiRoomImage(nil, type: .extraLarge, label: viewModel.firstMember.member.name.getOrNil(idx: 0) ?? "-")
                Image(icon: .addFill)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g600))
            }
            VStack(spacing: 4) {
                Text("채팅방 이름")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .padding(.top, 6)
                    .padding(.leading, 4)
                SeugiTextField(viewModel.emptyRoomName, text: $viewModel.roomName)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .seugiTopBar(
            title: "",
            subView: {
                SeugiButton.small("완료", type: .transparent, isLoading: viewModel.createRoomFlow.is(.fetching)) {
                    if let selectedWorkspace = mainViewModel.selectedWorkspace,
                       let member = mainViewModel.profile.data?.member {
                        viewModel.createGroupChat(
                            workspaceId: selectedWorkspace.workspaceId,
                            memberId: member.id
                        )
                    }
                }
            }
        )
        .onReceive(viewModel.$createRoomFlow) { flow in
            if case .failure = flow {
                alertProvider.present(
                    .init(title: "채팅방 만들기 실패")
                    .primaryButton("확인")
                )
            }
        }
        .onReceive(viewModel.$createdRoom) { flow in
            if case .success(let room) = flow {
                router.replace([MainDestination.chatDetail(room: room)])
            }
        }
    }
}
