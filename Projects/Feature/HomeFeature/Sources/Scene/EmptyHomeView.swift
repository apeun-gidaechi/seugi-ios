import SwiftUI
import Component
import SwiftUIUtil

public struct EmptyHomeView: View {
    
    public init() {}
    
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
            }
            Text("내 학교를 등록해주세요")
                .seugiColor(.gray(.g600))
                .font(.body(.b2))
            SeugiButton.large("등록하러 가기", type: .gray) {
                // TODO: handle action
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
            }
            .padding(4)
            Text("학교를 등록하고 시간표를 확인하세요")
                .seugiColor(.gray(.g600))
                .font(.body(.b2))
                .padding(.vertical, 12)
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
            }
            Text("학교를 등록하고 급식을 확인하세요")
                .seugiColor(.gray(.g600))
                .font(.body(.b2))
                .padding(.vertical, 12)
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
            Text("학교를 등록하고 캣스기와 대화해 보세요")
                .seugiColor(.gray(.g600))
                .font(.body(.b2))
                .padding(.vertical, 12)
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
            }
            .padding(4)
            Text("학교를 등록하고 일정을 확인하세요")
                .seugiColor(.gray(.g600))
                .font(.body(.b2))
                .padding(.vertical, 12)
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
