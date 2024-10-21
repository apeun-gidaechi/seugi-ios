import SwiftUI
import Component

struct HomeWorkspaceContainer: View {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    private let flow: HomeFetchFlow
    private let action: () -> Void
    
    init(
        for flow: HomeFetchFlow,
        action: @escaping () -> Void
    ) {
        self.flow = flow
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: action) {
                HStack(spacing: 8) {
                    HomeHeadlineIcon(icon: .schoolFill)
                    Text("내 학교")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                    HomeArrowIcon()
                }
                .padding(4)
            }
            .scaledButtonStyle()
            switch flow {
            case .fetching:
                ProgressView()
            case .empty:
                Text("내 학교를 등록해주세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
            case .finished:
                if let workspace = mainViewModel.selectedWorkspace {
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
