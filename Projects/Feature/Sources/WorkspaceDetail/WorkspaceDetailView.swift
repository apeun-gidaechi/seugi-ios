import SwiftUI
import Component
import Domain

struct WorkspaceDetailView: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @State private var isSheetPresent: Bool = false
    
    private var workspace: Workspace? {
        mainViewModel.selectedWorkspace
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let workspace {
                    HStack(spacing: 16) {
                        SeugiRoundedCircleAsyncImage.extraSmall(url: workspace.workspaceImageUrl)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(workspace.workspaceName)
                                .font(.body(.b1))
                                .seugiColor(.sub(.black))
                                .padding(.leading, 4)
                            SeugiButton.small("학교 전환", type: .gray) {
                                isSheetPresent = true
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                }
                LazyVStack(spacing: 0) {
                    SeugiDivider(thickness: .thick)
                    SettingWorkspaceHeadline(icon: .settingFill)
                        .padding(.top, 6)
                    SeugiListItem.icon(title: "일반", icon: .expandRightLine)
                        .button {
                            router.navigate(to: MainDestination.settingGeneral)
                        }
                        .scaledButtonStyle()
                    SeugiListItem.icon(title: "알림 설정", icon: .expandRightLine)
                        .button {
                            router.navigate(to: MainDestination.settingAlarm)
                        }
                        .scaledButtonStyle()
                    SettingWorkspaceHeadline(icon: .personFill)
                        .padding(.top, 24)
                    SeugiListItem.icon(title: "멤버", icon: .expandRightLine)
                        .button {
                            router.navigate(to: MainDestination.manageMember)
                        }
                        .scaledButtonStyle()
                    if let workspaceRole = mainViewModel.workspaceRole,
                       workspaceRole >= .teacher {
                        SeugiListItem.icon(title: "멤버 초대", icon: .expandRightLine)
                            .button {
                                router.navigate(to: MainDestination.invitationMember)
                            }
                            .scaledButtonStyle()
                    }
                }
            }
            .padding(.top, 12)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar(title: "내 학교")
        .sheet(isPresented: $isSheetPresent) {
            sheet
        }
        .onChange(of: mainViewModel.selectedWorkspace) { _ in // UX - 학교 선택하면 메인 화면으로 이동
            router.navigateToRoot()
        }
    }
    
    @ViewBuilder
    private var sheet: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                ForEach(mainViewModel.workspaces.data ?? [], id: \.workspaceId) { workspace in
                    Button {
                        mainViewModel.selectedWorkspace = workspace
                        isSheetPresent = false
                    } label: {
                        HomeWorkspaceCell(workspace: workspace, workspaceRole: mainViewModel.workspaceRole ?? .student)
                    }
                    .scaledButtonStyle()
                }
            }
            HStack(spacing: 8) {
                Spacer()
                SeugiButton.small("새 학교 만들기", type: .gray) {
                    router.navigate(to: MainDestination.createWorkspace)
                    isSheetPresent = false
                }
                SeugiButton.small("기존 학교 가입", type: .primary) {
                    router.navigate(to: MainDestination.joinWorkspaceRole)
                    isSheetPresent = false
                }
            }
        }
        .padding(16)
        .adjustedHeightSheet()
    }
}
