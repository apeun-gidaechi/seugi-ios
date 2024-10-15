import SwiftUI
import Component
import Domain

public struct ProfileView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isSheetPresent: Bool = false
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    appState.profile.makeView {
                        ProgressView()
                    } success: { profile in
                        SeugiAvatar(profile.member.picture, type: .medium)
                        Text(profile.nameAndNick)
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                    } failure: { _ in }
                    Spacer()
                    Image(icon: .settingFill)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 32, height: 32)
                        .button {
                            router.navigate(to: MainDestination.settingProfile)
                        }
                        .scaledButtonStyle()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                SeugiDivider(thickness: .thick)
                appState.profile.makeView {
                    ProgressView()
                } success: { profile in
                    ProfileCell("상태메세지", value: profile.status) {
                        viewModel.selectedProfleInfo = \.status
                    }
                    ProfileCell("직위", value: profile.spot) {
                        viewModel.selectedProfleInfo = \.spot
                    }
                    ProfileCell("소속", value: profile.belong) {
                        viewModel.selectedProfleInfo = \.belong
                    }
                    ProfileCell("휴대전화번호", value: profile.phone) {
                        viewModel.selectedProfleInfo = \.phone
                    }
                    ProfileCell("유선전화번호", value: profile.wire) {
                        viewModel.selectedProfleInfo = \.wire
                    }
                    ProfileCell("근무위치", value: profile.location) {
                        viewModel.selectedProfleInfo = \.location
                    }
                } failure: { _ in }
            }
        }
        .seugiBackground(.sub(.white))
        .seugiTopBar(title: "내 프로필", showBackButton: false)
        .onReceive(viewModel.$updateProfileFlow) { flow in
            switch flow {
            case .success:
                alertProvider.present(
                    .init(title: "\(viewModel.selectedProfleInfolabel) 수정 성공")
                )
                appState.fetchMyInfo()
            case .failure:
                alertProvider.present(
                    .init(title: "\(viewModel.selectedProfleInfolabel) 수정 실패")
                    .primaryButton("확인")
                )
            default:
                break
            }
        }
        .onChange(of: profile, initial: true) {
            viewModel.updateProfile = $0
        }
        .onChange(of: viewModel.selectedProfleInfo) { _ in
            self.isSheetPresent = true
        }
        .sheet(isPresented: $isSheetPresent, content: sheetContent)
    }
    
    @ViewBuilder
    func sheetContent() -> some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(viewModel.selectedProfleInfolabel) 수정")
                    .padding(.leading, 4)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                SeugiTextField(text: .init {
                    viewModel.updateProfileContent ?? ""
                } set: {
                    viewModel.updateProfileContent = $0
                })
            }
            SeugiButton.large("저장", type: .primary) {
                guard let selectedWorkspace = appState.selectedWorkspace else {
                    return
                }
                self.viewModel.updateProfile(workspaceId: selectedWorkspace.workspaceId)
                self.isSheetPresent = false
            }
        }
        .padding(20)
        .presentationDetents([.height(220)])
    }
}

extension KeyPath<RetrieveProfile, String> {
    var label: String {
        switch self {
        case \.status: "상태메세지"
        case \.nick: "닉네임"
        case \.spot: "직위"
        case \.belong: "소속"
        case \.phone: "휴대전화번호"
        case \.wire: "유선전화번호"
        case \.location: "근무위치"
        default: ""
        }
    }
}
