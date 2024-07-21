import SwiftUI
import Component
import BaseFeatureInterface
import JoinSchoolFeatureInterface

public struct SelectingJobView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: JoinSchoolViewModel
    @State private var selectedTab: JobType = .student
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.subtitle(.s1))
                    .toLeading()
                    .padding(.leading, 4)
                HStack {
                    ForEach(JobType.allCases, id: \.self) { tab in
                        Button {
                            withAnimation(.spring(duration: 0.4)) {
                                selectedTab = tab
                            }
                        } label: {
                            JobCell(jobType: tab, isActive: tab == selectedTab)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                router.navigate(to: JoinSchoolDestination.waitingJoin)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("학교 가입")
        .alertWithAnyView("가입 요청 실패", when: failureDialog(for: $viewModel.joinFlow)) {
            Button("닫기", role: .cancel) {}
        } message: {
            Text("잠시 후 다시 시도해 주세요")
        }
    }
}
