import SwiftUI
import Component

public struct JoinWorkspaceRoleView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var viewModel: JoinWorkspaceViewModel
    @State private var selectedTab: JobType = .student
    
    public init() {}
}

extension JoinWorkspaceRoleView: View {
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.subtitle(.s1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)
                HStack(spacing: 8) {
                    ForEach(JobType.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            WorkspaceRoleCell(jobType: tab, isActive: tab == selectedTab)
                                .animation(.spring(duration: 0.4), value: selectedTab)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            SeugiButton.large(
                "계속하기", type: .primary,
                isLoading: viewModel.joinFlow.is(.fetching)
            ) {
                viewModel.roleType = selectedTab.toWorkspaceRole()
                router.navigate(to: MainDestination.joinWorkspaceCode)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar(title: "학교 가입")
    }
}
