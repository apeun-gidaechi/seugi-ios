import SwiftUI
import Component
import Domain
import PhotosUI

public struct SettingProfileView: View {
    
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var fileViewModel: FileViewModel
    @EnvironmentObject private var alert: AlertProvider
    @ObservedObject private var viewModel = SettingProfileViewModel()
    
    // photo
    @State private var showPhotoPicker: Bool = false
    @State private var profileImagePhoto: PhotosPickerItem?
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            if let profile {
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
                .padding(.vertical, 8)
                .button {
                    showPhotoPicker = true
                }
                .applyAnimation()
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
                        alert.present("로그아웃 하시겠습니까?")
                            .primaryButton("로그아웃") {
                                appState.logout()
                            }
                            .secondaryButton("아니요") {}
                            .show()
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "회원 탈퇴", icon: .expandRightLine, titleColor: .red(.r500))
                    .button {
                        alert.present("정말 회원 탈퇴하시겠습니까?")
                            .message("회원 탈퇴 시 모든 정보가 삭제 됩니다")
                            .primaryButton("탈퇴") {
                                viewModel.removeMember()
                            }
                            .secondaryButton("취소")
                            .show()
                    }
                    .applyAnimation()
                SeugiDivider(thickness: .thick)
                SeugiListItem.icon(title: "개인정보 처리 방침", icon: .expandRightLine)
                    .button {
                        openURL.callAsFunction(URL(string: "https://byungjjun.notion.site/58f95c1209fb48b4b74434701290f838?pvs=74") ?? .aboutBlank)
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "서비스 운영 정책", icon: .expandRightLine)
                    .button {
                        openURL.callAsFunction(URL(string: "https://byungjjun.notion.site/5ba79e224f53439bbfa3607e581fe6bf?pvs=74") ?? .aboutBlank)
                    }
                    .applyAnimation()
            }
            Spacer()
        }
        .seugiTopBar("설정")
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $profileImagePhoto,
            matching: .any(of: [.images, .screenshots])
        )
        .onChange(of: profileImagePhoto) { photo in
            guard let photo else {
                return
            }
            fileViewModel.uploadPhoto(photo: photo) { url in
                viewModel.editMember(picture: url)
            } failure: { error in
                viewModel.editMemberFlow = .failure(error)
            }
        }
        .onChange(of: appState.profile, initial: true) {
            viewModel.member = $0.data?.member
        }
        .onReceive(viewModel.$editMemberFlow) { flow in
            switch flow {
            case .success:
                appState.fetchMyInfo()
                alert.present("정보 수정 성공")
                    .show()
            case .failure:
                alert.present("정보 수정 실패")
                    .primaryButton("확인")
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
        }
        .onReceive(viewModel.$removeMemberFlow) { flow in
            switch flow {
            case .success:
                appState.logout()
            case .failure:
                alert.present("탈퇴 실패")
                    .primaryButton("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
        }
    }
}
