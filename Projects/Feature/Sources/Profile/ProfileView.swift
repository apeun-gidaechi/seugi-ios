import SwiftUI
import Component
import Domain

struct ProfileView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: RouterViewModel
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isSheetPresent: Bool = false
    
    private var profile: RetrieveProfile? {
        mainViewModel.profile.data
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    mainViewModel.profile.makeView {
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
                mainViewModel.profile.makeView {
                    ProgressView()
                } success: { profile in
                    ProfileCell("상태메세지", value: profile.status) {
                        viewModel.selectedProfleInfo = \.status
                        isSheetPresent = true
                    }
                    ProfileCell("직위", value: profile.spot) {
                        viewModel.selectedProfleInfo = \.spot
                        isSheetPresent = true
                    }
                    ProfileCell("소속", value: profile.belong) {
                        viewModel.selectedProfleInfo = \.belong
                        isSheetPresent = true
                    }
                    ProfileCell("휴대전화번호", value: profile.phone) {
                        viewModel.selectedProfleInfo = \.phone
                        isSheetPresent = true
                    }
                    ProfileCell("유선전화번호", value: profile.wire) {
                        viewModel.selectedProfleInfo = \.wire
                        isSheetPresent = true
                    }
                    ProfileCell("근무위치", value: profile.location) {
                        viewModel.selectedProfleInfo = \.location
                        isSheetPresent = true
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
                mainViewModel.fetchMyInfo()
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
        .sheet(isPresented: $isSheetPresent, content: sheetContent)
    }
    
    @ViewBuilder
    func sheetContent() -> some View {
        ProfileEditSheetView(
            title: "\(viewModel.selectedProfleInfolabel) 수정",
            text: .init {
                viewModel.updateProfileContent ?? ""
            } set: {
                viewModel.updateProfileContent = $0
            },
            keyboardType: viewModel.selectedProfleInfo?.keyboardType ?? .default,
            limit: viewModel.selectedProfleInfo?.limit ?? nil
        ) {
            guard let selectedWorkspace = mainViewModel.selectedWorkspace else {
                return
            }
            self.viewModel.updateProfile(workspaceId: selectedWorkspace.workspaceId)
            self.isSheetPresent = false
            self.viewModel.selectedProfleInfo = nil
        }
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
    
    var keyboardType: UIKeyboardType {
        switch self {
        case \.phone, \.wire: .numberPad
        default: .default
        }
    }
    
    var limit: Int? {
        switch self {
        case \.phone, \.wire: 11
        default: nil
        }
    }
}
