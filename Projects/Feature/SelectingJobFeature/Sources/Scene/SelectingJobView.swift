import SwiftUI
import DesignSystem
import BaseFeatureInterface

public struct SelectingJobView: View {
    
    @EnvironmentObject private var router: Router
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
                            selectedTab = tab
                        } label: {
                            JobCell(jobType: tab, isActive: tab == selectedTab)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            Button {
                router.navigate(to: SelectingJobDestination.emailSignIn)
            } label: {
                Text("이미 계정이 있으신가요?")
                    .seugiColor(.primary(.p500))
                    .font(.body(.b1))
            }
            SeugiButton.large("계속하기", type: .primary) {
                router.navigate(to: SelectingJobDestination.emailSignUp)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("회원가입")
    }
}
