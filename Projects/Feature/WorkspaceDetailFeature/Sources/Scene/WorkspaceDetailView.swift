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
                            HStack(spacing: 8) {
                                SeugiButton.small("학교 전환", type: .gray) {
                                    isSheetPresent = true
                                }
                                .expanded()
                                SeugiButton.small("학교 설정", type: .gray) {
                                    router.navigate(to: WorkspaceDetailDestination.settingWorkspace)
                                }
                                .expanded()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                LazyVStack(spacing: 0) {
                    SeugiDivider(thickness: .thick)
                    SeugiListItem.icon(title: "멤버 보기", icon: .expandRightLine)
                        .leadingIcon(.personFill)
                        .button {
                            router.navigate(to: WorkspaceDetailDestination.workspaceMembers)
                        }
                }
            }
            .padding(.top, 12)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar("내 학교")
        .sheet(isPresented: $isSheetPresent) {
            VStack(spacing: 16) {
                VStack(spacing: 4) {
                    ForEach(appState.workspaces.data ?? [], id: \.workspaceId) { workspace in
                        HomeWorkspaceCell(workspace: workspace, workspaceRole: appState.workspaceRole ?? .student) {
                            router.navigate(to: WorkspaceDetailDestination.settingWorkspace)
                            isSheetPresent = false
                        }
                        .onTapGesture {
                            appState.selectedWorkspace = workspace
                            isSheetPresent = false
                        }
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
}
