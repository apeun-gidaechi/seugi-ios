import SwiftUI
import Component
import BaseFeatureInterface
import WorkspaceDetailFeatureInterface
import Domain

public struct WorkspaceDetailView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
    @State private var isSheetPresent = false
    
    private var workspace: Workspace? {
        appState.selectedWorkspace
    }
    
    public var body: some View {
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
                                //
                            }
                            .applyAnimation()
                        SeugiListItem.icon(title: "알림 설정", icon: .expandRightLine)
                            .button {
                                //
                            }
                            .applyAnimation()
                        SettingWorkspaceHeadline(icon: .personFill)
                            .padding(.top, 24)
                        SeugiListItem.icon(title: "멤버", icon: .expandRightLine)
                            .button {
                                router.navigate(to: WorkspaceDetailDestination.manageMember)
                            }
                            .applyAnimation()
                        SeugiListItem.icon(title: "멤버 초대", icon: .expandRightLine)
                            .button {
                                router.navigate(to: WorkspaceDetailDestination.invitationMember)
                            }
                            .applyAnimation()
                }
            }
            .padding(.top, 12)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar("내 학교")
        .sheet(isPresented: $isSheetPresent) {
            sheet
        }
    }
    
    @ViewBuilder
    private var sheet: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                ForEach(appState.workspaces.data ?? [], id: \.workspaceId) { workspace in
                    HomeWorkspaceCell(workspace: workspace, workspaceRole: appState.workspaceRole ?? .student)
                        .button {
                            appState.selectedWorkspace = workspace
                            isSheetPresent = false
                        }
                        .applyAnimation()
                }
            }
            HStack(spacing: 8) {
                Spacer()
                SeugiButton.small("새 학교 만들기", type: .gray) {
                    router.navigate(to: WorkspaceDetailDestination.createWorkspace)
                    isSheetPresent = false
                }
                SeugiButton.small("기존 학교 가입", type: .primary) {
                    router.navigate(to: WorkspaceDetailDestination.joinWorkspace)
                    isSheetPresent = false
                }
            }
        }
        .padding(16)
        .adjustedHeightSheet()
    }
}
