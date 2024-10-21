import SwiftUI
import Component
import Domain
import DateUtil
import SwiftUtil
import SwiftUIUtil

struct MealView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @StateObject private var viewModel = MealViewModel()
    
    private var weeks: [[Date?]] {
        viewModel.selectedCalendar.weeks
    }
    // 선택된 날짜가 몇 주 인지
    private var selectedDateWeekCount: Int {
        for (idx, week) in Array(weeks.enumerated()) {
            for date in week {
                guard let date else { continue }
                if date.equals(viewModel.selectedDate, components: [.year, .month, .day]) {
                    return idx
                }
            }
        }
        return 0
    }
}

extension MealView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                makeCalendar()
                    .padding(.top, 12)
                if let meals = viewModel.selectedMeal {
                    ForEach(meals.indices, id: \.self) { index in
                        let meal = meals[index]
                        MealCell(meal: meal)
                        if index != meals.count - 1 {
                            SeugiDivider()
                        }
                    }
                    .padding(.horizontal, 16)
                } else {
                    VStack(spacing: 12) {
                        Text("급식이 없어요")
                            .font(.body(.b2))
                            .seugiColor(.gray(.g600))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .bottomGradientMask()
        .seugiTopBar(title: "급식")
        .onAppear {
            guard let id = mainViewModel.selectedWorkspace?.workspaceId else { return }
            viewModel.onCreate(workspaceId: id)
        }
    }
    
    @ViewBuilder
    private func makeCalendar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { date in
                    Text(date)
                        .font(.body(.b2))
                        .seugiColor(.gray(.g600))
                        .frame(maxWidth: .infinity)
                }
            }
            VStack(spacing: 0) {
                ForEach(weeks, id: \.hashValue) { week in
                    HStack(spacing: 0) {
                        ForEach(Array(week.enumerated()), id: \.offset) { _, date in
                            let selected: Bool = if let date {
                                viewModel.selectedDate.equals(date, components: [.year, .month, .day])
                            } else {
                                false
                            }
                            Button {
                                if !selected, let date {
                                    viewModel.selectedDate = date
                                    viewModel.selectedCalendar = date
                                }
                            } label: {
                                CalendarDateCell(date: date, selected: selected)
                            }
                            .scaledButtonStyle()
                        }
                    }
                }
            }
            .padding(.bottom, 8)
            .clipped()
            SeugiDivider()
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
    }
}
