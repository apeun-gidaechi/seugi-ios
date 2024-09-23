import SwiftUI
import Component

struct HomeWorkspaceContainer: View {
    @AppState private var appState
    
    private let flow: HomeFetchFlow
    
    init(for flow: HomeFetchFlow) {
        self.flow = flow
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                HomeHeadlineIcon(icon: .schoolFill)
                Text("내 학교")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                Spacer()
                HomeArrowIcon()
            }
            switch flow {
            case .fetching:
                ProgressView()
            case .failure:
                Text("내 학교를 등록해주세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
            case .success:
                if let workspace = appState.selectedWorkspace {
                    Text(workspace.workspaceName)
                        .font(.subtitle(.s2))
                        .seugiColor(.gray(.g600))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .applyCardEffect()
    }
}
