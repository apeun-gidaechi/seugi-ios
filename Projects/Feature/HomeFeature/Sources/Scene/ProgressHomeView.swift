import SwiftUI
import Component
import SwiftUIUtil

public struct ProgressHomeView: View {
    
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
            ProgressView()
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
            ProgressView()
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
            ProgressView()
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
            ProgressView()
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
            ProgressView()
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
