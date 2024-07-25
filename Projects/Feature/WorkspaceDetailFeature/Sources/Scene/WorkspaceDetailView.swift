import SwiftUI
import Component
import BaseFeatureInterface
import WorkspaceDetailFeatureInterface
import Domain

public struct WorkspaceDetailView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
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
                                    //
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
    }
}
