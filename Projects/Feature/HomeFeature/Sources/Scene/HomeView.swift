import SwiftUI
import Component
import SwiftUIUtil
import BaseFeatureInterface
import HomeFeatureInterface

public struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = HomeViewModel()
    @Namespace private var currentWorkspaceNamespace
    @Namespace private var todayScheduleNamespace
    @Namespace private var todayMealNamespace
    @Namespace private var catSeugiNamespace
    @Namespace private var commingScheduleNamespace
    
    private let flow: HomeFetchFlow
    
    public init(
        flow: HomeFetchFlow
    ) {
        self.flow = flow
    }
    
    private let dummySchedule = [
        "국어",
        "수학",
        "음악",
        "사회",
        "과학",
        "일어",
        "창체"
    ]
    private let dummyNow = 3
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                currentWorkspace
                    .padding(.top, 8)
                    .button {
                        router.navigate(to: HomeDestination.workspaceDetail)
                    }
                    .applyAnimation()
                todaySchedule
                todayMeal
                catSeugi
                commingSchedule
                    .padding(.bottom, 80)
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .seugiBackground(.primary(.p050))
        .seugiTopBar("홈", background: .seugi(.primary(.p050)))
        .hideBackButton()
    }
    
    @ViewBuilder
    private var currentWorkspace: some View {
        Group {
            switch flow {
            case .fetching:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .schoolFill)
                        Text("내 학교")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    ProgressView()
                }
                .applyCardEffect()
            case .failure:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .schoolFill)
                        Text("내 학교")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    Text("내 학교를 등록해주세요")
                        .seugiColor(.gray(.g600))
                        .font(.body(.b2))
                }
                .applyCardEffect()
            case .success:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .schoolFill)
                        Text("내 학교")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                        Image(icon: .expandRightLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.gray(.g500))
                            .frame(width: 24, height: 24)
                    }
                    if let workspace = appState.selectedWorkspace {
                        Text(workspace.workspaceName)
                            .font(.subtitle(.s2))
                            .seugiColor(.gray(.g600))
                            .toLeading()
                    }
                }
                .applyCardEffect()
            }
        }
        .matchedGeometryEffect(id: "currentWorkspace", in: currentWorkspaceNamespace)
    }
    
    @ViewBuilder
    private var todaySchedule: some View {
        Group {
            switch flow {
            case .fetching:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .bookFill)
                        Text("오늘의 시간표")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    .padding(4)
                    ProgressView()
                }
                .applyCardEffect()
            case .failure:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .bookFill)
                        Text("오늘의 시간표")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    .padding(4)
                    Text("학교를 등록하고 시간표를 확인하세요")
                        .seugiColor(.gray(.g600))
                        .font(.body(.b2))
                        .padding(.vertical, 12)
                }
                .applyCardEffect()
            case .success:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .bookFill)
                        Text("오늘의 시간표")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                        Image(icon: .expandRightLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.gray(.g500))
                            .frame(width: 24, height: 24)
                    }
                    .padding(4)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(Array(dummySchedule.enumerated()), id: \.offset) { idx, _ in
                                let now = dummyNow == idx
                                Text("\(idx + 1)")
                                    .font(.body(.b1))
                                    .seugiColor(now ? .primary(.p500) : .primary(.p300))
                                    .padding(.vertical, 8)
                                    .toHorizontal()
                            }
                        }
                        HStack(spacing: 0) {
                            ForEach(Array(dummySchedule.enumerated()), id: \.offset) { idx, subject in
                                let now = dummyNow == idx
                                Text(subject)
                                    .font(.body(.b1))
                                    .seugiColor(now ? .sub(.white) : dummyNow < idx ? .primary(.p200) : .primary(.p300))
                                    .padding(.vertical, 8)
                                    .toHorizontal()
                                    .if(dummyNow >= idx) { view in
                                        view.seugiBackground(.primary(.p500))
                                    }
                                    .if(idx == 0) { view in
                                        view.cornerRadius(16, corners: [.topLeft, .bottomLeft])
                                    }
                                    .if(now) { view in
                                        view.cornerRadius(16, corners: [.topRight, .bottomRight])
                                    }
                            }
                        }
                        .seugiBackground(.primary(.p100))
                        .cornerRadius(16, corners: .allCorners)
                    }
                }
                .applyCardEffect()
            }
        }
        .matchedGeometryEffect(id: "todaySchedule", in: todayScheduleNamespace)
    }
    
    @ViewBuilder
    private var todayMeal: some View {
        Group {
            switch flow {
            case .fetching:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .utensilsLine)
                        Text("오늘의 급식")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    ProgressView()
                }
                .applyCardEffect()
            case .failure:
                
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .utensilsLine)
                        Text("오늘의 급식")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                    }
                    Text("학교를 등록하고 급식을 확인하세요")
                        .seugiColor(.gray(.g600))
                        .font(.body(.b2))
                        .padding(.vertical, 12)
                }
                .applyCardEffect()
            case .success:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .utensilsLine)
                        Text("오늘의 급식")
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                        Spacer()
                        Image(icon: .expandRightLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.gray(.g500))
                            .frame(width: 24, height: 24)
                    }
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("""
                             오리훈제볶음밥
                             간장두부조립
                             배추김치
                             초코첵스시리얼+우유
                             오렌지
                             """)
                            .multilineTextAlignment(.leading)
                            .font(.body(.b2))
                            .seugiColor(.gray(.g700))
                            Text("872kcal")
                                .font(.caption(.c1))
                                .seugiColor(.sub(.white))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .seugiBackground(.primary(.p500))
                                .cornerRadius(100)
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            Image(image: .apple1)
                                .resizable()
                                .frame(width: 94, height: 94)
                            Text("아침")
                                .font(.caption(.c1))
                                .seugiColor(.gray(.g500))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .applyCardEffect()
            }
        }
        .matchedGeometryEffect(id: "todayMeal", in: todayMealNamespace)
    }
    
    @ViewBuilder
    private var catSeugi: some View {
        Group {
            switch flow {
            case .fetching:
                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        SeugiAppIcon(type: .extraSmall)
                        Text("캣스기")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                    }
                    .padding(4)
                    ProgressView()
                }
                .applyCardEffect()
            case .failure:
                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        SeugiAppIcon(type: .extraSmall)
                        Text("캣스기")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                    }
                    .padding(4)
                    Text("학교를 등록하고 캣스기와 대화해 보세요")
                        .seugiColor(.gray(.g600))
                        .font(.body(.b2))
                        .padding(.vertical, 12)
                }
                .applyCardEffect()
            case .success:
                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        SeugiAppIcon(type: .extraSmall)
                        Text("캣스기")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                    }
                    .padding(4)
                    HStack {
                        Text("2학년 4반에서 아무나 한명 뽑아줘...")
                            .font(.subtitle(.s2))
                            .seugiColor(.gray(.g500))
                        Spacer()
                        Image(icon: .searchLine)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(SeugiGradientSystem.primary)
                            .frame(width: 28, height: 28)
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 52)
                    .overlay {
                        RoundedCornerShape(radius: 26)
                            .stroke(SeugiGradientSystem.primary, lineWidth: 1.5)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("지난주")
                            .padding(.leading, 4)
                            .seugiColor(.gray(.g600))
                            .font(.body(.b2))
                        makeAIHistory()
                        makeAIHistory()
                    }
                }
                .applyCardEffect()
            }
        }
        .matchedGeometryEffect(id: "catSeugi", in: catSeugiNamespace)
    }
    
    @ViewBuilder
    private var commingSchedule: some View {
        Group {
            switch flow {
            case .fetching:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .calendarLine)
                        Text("다가오는 일정")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                    }
                    .padding(4)
                    ProgressView()
                }
                .applyCardEffect()
            case .failure:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .calendarLine)
                        Text("다가오는 일정")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                    }
                    .padding(4)
                    Text("학교를 등록하고 일정을 확인하세요")
                        .seugiColor(.gray(.g600))
                        .font(.body(.b2))
                        .padding(.vertical, 12)
                }
                .applyCardEffect()
            case .success:
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        makeHeadlineIcon(icon: .calendarLine)
                        Text("다가오는 일정")
                            .seugiColor(.sub(.black))
                            .font(.subtitle(.s2))
                        Spacer()
                        Image(icon: .expandRightLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.gray(.g500))
                            .frame(width: 24, height: 24)
                    }
                    .padding(4)
                    VStack(spacing: 16) {
                        ForEach(0..<3, id: \.self) { _ in
                            HStack(spacing: 0) {
                                Text("7/21")
                                    .font(.body(.b1))
                                    .seugiColor(.primary(.p500))
                                Text("체육대회")
                                    .font(.body(.b2))
                                    .seugiColor(.sub(.black))
                                    .padding(.leading, 10)
                                Spacer()
                                Text("D-3")
                                    .font(.caption(.c1))
                                    .seugiColor(.gray(.g600))
                            }
                        }
                    }
                }
                .applyCardEffect()
            }
        }
        .matchedGeometryEffect(id: "commingSchedule", in: commingScheduleNamespace)
    }
    
    private func makeAIHistory() -> some View {
        HStack {
            Text("급식에 복어가 나오는 날이 언제...")
                .font(.body(.b1))
                .seugiColor(.sub(.black))
            Spacer()
            Text("6월 21일")
                .font(.body(.b2))
                .seugiColor(.gray(.g600))
        }
        .padding(12)
        .seugiBackground(.gray(.g200))
        .cornerRadius(4)
    }
    
    private func makeHeadlineIcon(icon: SeugiIconography) -> some View {
        Image(icon: icon)
            .resizable()
            .renderingMode(.template)
            .seugiColor(.gray(.g600))
            .frame(width: 24, height: 24)
            .padding(4)
            .seugiBackground(.gray(.g100))
            .cornerRadius(8, corners: .allCorners)
    }
}

private extension View {
    func applyCardEffect() -> some View {
        self
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .padding(.bottom, 16)
            .seugiBackground(.sub(.white))
            .cornerRadius(12, corners: .allCorners)
            .shadow(.evBlack(.ev1))
    }
}
