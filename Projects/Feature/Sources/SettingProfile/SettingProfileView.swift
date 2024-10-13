import SwiftUI
import PhotosUI
import Component
import Domain

public struct SettingProfileView {
    @Environment(\.openURL) private var openURL
    
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var alert: AlertProvider
    
    @StateObject private var viewModel = SettingProfileViewModel()
    @StateObject private var fileViewModel = FileViewModel()
    
    @State private var showPhotoPicker: Bool = false
    @State private var profileImagePhoto: PhotosPickerItem?
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
}

extension SettingProfileView: View {
    public var body: some View {
        VStack(spacing: 8) {
            if let profile {
                Button {
                    showPhotoPicker = true
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        SeugiAvatar(profile.member.picture, type: .extraLarge)
                        if profile.member.picture.isEmpty {
                            Image(icon: .addFill)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .seugiColor(.gray(.g600))
                        }
                    }
                }
                .scaledButtonStyle()
                .padding(.vertical, 8)
                HStack(spacing: 4) {
                    Text(profile.member.name)
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Image(icon: .writeLine)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .seugiColor(.gray(.g500))
                }
            }
            LazyVStack(spacing: 0) {
                SeugiListItem.icon(title: "로그아웃", icon: .expandRightLine)
                    .button {
                        alert.present(
                            .init(title: "로그아웃 하시겠습니까?")
                            .primaryButton("로그아웃") {
                                appState.logout()
                                router.navigateToRoot()
                            }
                            .secondaryButton("아니요")
                        )
                    }
                    .scaledButtonStyle()
                SeugiListItem.icon(title: "회원 탈퇴", icon: .expandRightLine, titleColor: .red(.r500))
                    .button {
                        alert.present(
                            .init(title: "정말 회원 탈퇴하시겠습니까?")
                            .message("회원 탈퇴 시 모든 정보가 삭제 됩니다")
                            .primaryButton("탈퇴") {
                                viewModel.removeMember()
                            }
                            .secondaryButton("취소")
                        )
                    }
                    .scaledButtonStyle()
                SeugiDivider(thickness: .thick)
                SeugiListItem.icon(title: "개인정보 처리 방침", icon: .expandRightLine)
                    .button {
                        openURL.callAsFunction(URL(string: "https://byungjjun.notion.site/58f95c1209fb48b4b74434701290f838?pvs=74") ?? .aboutBlank)
                    }
                    .scaledButtonStyle()
                SeugiListItem.icon(title: "서비스 운영 정책", icon: .expandRightLine)
                    .button {
                        openURL.callAsFunction(URL(string: "https://byungjjun.notion.site/5ba79e224f53439bbfa3607e581fe6bf?pvs=74") ?? .aboutBlank)
                    }
                    .scaledButtonStyle()
            }
            Spacer()
        }
        .seugiTopBar(title: "설정")
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $profileImagePhoto,
            matching: .any(of: [.images, .screenshots])
        )
        .onChange(of: profileImagePhoto) { photo in
            guard let photo else {
                return
            }
            Task {
                await fileViewModel.uploadPhoto(photo: photo)
            }
        }
        .onReceive(fileViewModel.$fileFlow) { flow in
            switch flow {
            case .success(let file):
                if let profile = appState.profile.data {
                    viewModel.editMember(picture: file.url, member: profile.member)
                }
            case .failure(let error):
                viewModel.editMemberFlow = .failure(error)
            default:
                break
            }
        }
        .onReceive(viewModel.$editMemberFlow) { flow in
            switch flow {
            case .success:
                appState.fetchMyInfo()
                alert.present(
                    .init(title: "정보 수정 성공")
                )
            case .failure:
                alert.present(
                    .init(title: "정보 수정 실패")
                    .primaryButton("확인")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
        .onReceive(viewModel.$removeMemberFlow) { flow in
            switch flow {
            case .success:
                appState.logout()
                router.navigateToRoot()
            case .failure:
                alert.present(
                    .init(title: "탈퇴 실패")
                    .primaryButton("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
    }
}
