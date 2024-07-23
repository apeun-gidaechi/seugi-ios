import SwiftUI
import Component
import Domain
import BaseFeatureInterface

public struct ProfileView: View {
    
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = ProfileViewModel()
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    SeugiAvatar(type: .medium)
                    Text(profile?.member.name ?? "")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                    Image(icon: .settingFill)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 32, height: 32)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                SeugiDivider(thickness: .thick)
                if let profile {
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
                }
            }
        }
        .seugiBackground(.sub(.white))
        .seugiTopBar("내 프로필")
        .hideBackButton()
        .sheet(isPresented: $viewModel.isSheetPresent) {
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
                    viewModel.updateProfile(workspaceId: selectedWorkspace.workspaceId)
                }
            }
            .padding(20)
            .presentationDetents([.height(220)])
        }
        .alertWithAnyView("\(viewModel.selectedProfleInfolabel) 수정 성공", when: successDialog(for: $viewModel.updateProfileFlow)) {
            Button("닫기") {}
        }
        .alertWithAnyView("\(viewModel.selectedProfleInfolabel) 수정 실패", when: failureDialog(for: $viewModel.updateProfileFlow)) {
            Button("확인") {}
        }
        .onAppear {
            viewModel.updateProfile = profile
        }
        .onChange(of: profile) {
            viewModel.updateProfile = $0
        }
        .onChangeIdleFlow(of: viewModel.updateProfileFlow) {
            appState.fetchMyInfo()
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
}
