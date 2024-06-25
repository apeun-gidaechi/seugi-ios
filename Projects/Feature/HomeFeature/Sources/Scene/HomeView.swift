import SwiftUI
import Component
import SwiftUIUtil

public struct HomeView: View {
    
    public init() {}
    
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
                todaySchedule
                todayMeal
                catSeugi
                commingSchedule
                    .padding(.bottom, 80)
            }
            .padding(.horizontal, 20)
        }
        .seugiBackground(.primary(.p050))
        .seugiTopBar("홈", background: .seugi(.primary(.p050)))
        .hideBackButton()
    }
    
    @ViewBuilder
    private var currentWorkspace: some View {
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
            HStack {
                Text("대구 소프트웨어 마이스터 고등학교")
                    .font(.subtitle(.s2))
                    .seugiColor(.gray(.g600))
                Spacer()
                SeugiButton.small("전환", type: .gray) {
                    // TODO: handle action
                }
            }
        }
        .applyCardEffect()
    }
    
    @ViewBuilder
    private var todaySchedule: some View {
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
    
    @ViewBuilder
    private var todayMeal: some View {
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
    
    @ViewBuilder
    private var catSeugi: some View {
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
    
    @ViewBuilder
    private var commingSchedule: some View {
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
