import SwiftUI
import Component

public struct JoinWorkspaceRoleView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var viewModel: JoinWorkspaceViewModel
    @State private var selectedTab: JobType = .student
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.subtitle(.s1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)
                HStack {
                    ForEach(JobType.allCases, id: \.self) { tab in
                        Button {
                            withAnimation(.spring(duration: 0.4)) {
                                selectedTab = tab
                            }
                        } label: {
                            WorkspaceRoleCell(jobType: tab, isActive: tab == selectedTab)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.isFetchJoinWorkspace) {
                viewModel.joinWorkspace()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar(title: "학교 가입")
        .onReceive(viewModel.$joinFlow) {
            switch $0 {
            case .success:
                router.navigate(to: MainDestination.joinWorkspaceCode)
            case .failure:
                alertProvider.present("가입 요청 실패")
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
            if case .failure = $0 {
            }
        }
    }
}
