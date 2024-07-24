import SwiftUI
import Component
import BaseFeatureInterface
import Domain
import PhotosUI

public struct SettingProfileView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var fileManager: SeugiFileManager
    @ObservedObject private var viewModel = SettingProfileViewModel()
    
    // photo
    @State private var showPhotoPicker = false
    @State private var profileImagePhoto: PhotosPickerItem?
    
    // session
    @State private var showLogoutDialog = false
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            if let profile {
                ZStack(alignment: .bottomTrailing) {
                    SeugiAvatar(profile.member.picture, type: .extraLarge)
                    Image(icon: .addFill)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .seugiColor(.gray(.g600))
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
                        showLogoutDialog = true
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "회원탈퇴", icon: .expandRightLine, titleColor: .red(.r500))
                    .button {
                        // TODO: Handle remove member
                    }
                    .applyAnimation()
                SeugiDivider(thickness: .thick)
                SeugiListItem.icon(title: "개인정보 처리 방침", icon: .expandRightLine)
                    .button {
                        // TODO: Handle to open url
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "서비스 운영 정책", icon: .expandRightLine)
                    .button {
                        // TODO: Handle to open url
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
            fileManager.uploadPhoto(photo: photo) { url in
                viewModel.editMember(picture: url)
            } failure: { error in
                viewModel.editMemberFlow = .failure(error)
            }
        }
        .onAppear {
            viewModel.member = appState.profile.data?.member
        }
        .onChange(of: appState.profile) {
            viewModel.member = $0.data?.member
        }
        .onChangeIdleFlow(of: viewModel.editMemberFlow) {
            appState.fetchMyInfo()
        }
        .alertWithAnyView("정보 수정 성공", when: successDialog(for: $viewModel.editMemberFlow)) {
            Button("닫기") {}
        }
        .alertWithAnyView("정보 수정 실패", when: failureDialog(for: $viewModel.editMemberFlow)) {
            Button("확인") {}
        } message: {
            Text("잠시 후 다시 시도해 주세요")
        }
        .alertWithAnyView("로그아웃 하시겠습니까?", when: $showLogoutDialog) {
            Button("아니요", role: .cancel) {}
            Button("로그아웃", role: .destructive) {
                appState.logout()
            }
        }
    }
}
