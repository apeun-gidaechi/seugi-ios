import SwiftUI
import Component
import ScopeKit

struct TimetableView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @StateObject private var viewModel = TimetableViewModel()
}

extension TimetableView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Image(icon: .expandLeftLine)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g500))
                Spacer()
                if let text = weekdayRangeText(date: viewModel.selectedMonth) {
                    Text(text)
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                }
                Spacer()
                Image(icon: .expandRightLine)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g500))
            }
            .padding(12)
            .seugiBackground(.sub(.white))
            .cornerRadius(12, corners: .allCorners)
            .shadow(.evBlack(.ev1))
            viewModel.timetables.makeView {
                ProgressView()
            } success: { timetables in
                VStack(spacing: 0) {
                    // Header
                    HStack(spacing: 0) {
                        Spacer().frame(width: 24)
                        ForEach(weekdaysLocalized.indices, id: \.self) { index in
                            let weekday = weekdaysLocalized[index]
                            Text(weekday)
                                .font(.caption(.c2))
                                .seugiColor(.gray(.g500))
                                .frame(height: 24)
                                .frame(maxWidth: .infinity)
                                .stroke(0, content: Color.seugi(.gray(.g100)))
                        }
                    }
                    // Body
                    HStack(spacing: 0) {
                        // Time
                        VStack(spacing: 0) {
                            ForEach(1...viewModel.maxCount, id: \.self) { time in
                                Text("\(time)")
                                    .font(.caption(.c2))
                                    .seugiColor(.gray(.g600))
                                    .frame(width: 24)
                                    .frame(maxHeight: .infinity)
                                    .stroke(0, content: Color.seugi(.gray(.g100)))
                            }
                        }
                        
                        // Subjects
                        ForEach(timetables.indices, id: \.self) { index in
                            let rows = timetables[index]
                            
                            VStack(spacing: 0) {
                                ForEach(rows.indices, id: \.self) { index in
                                    let timetable = rows[index]
                                    if let timetable {
                                        Text(timetable.subject)
                                            .font(.body(.b2))
                                            .seugiColor(.sub(.black))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .stroke(0, content: Color.seugi(.gray(.g100)))
                                    } else {
                                        Spacer()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .stroke(0, content: Color.seugi(.gray(.g100)))
                                    }
                                }
                            }
                        }
                    }
                }
                .seugiBackground(.sub(.white))
                .cornerRadius(12, corners: .allCorners)
                .shadow(.evBlack(.ev1))
            } failure: { _ in }
        }
        .padding(.horizontal, 16)
        .seugiTopBar(
            title: "시간표",
            colors: .default.copy(backgroundColor: .seugi(.primary(.p050)))
        )
        .onAppear {
            guard let workspaceId = mainViewModel.selectedWorkspace?.workspaceId else { return }
            viewModel.onAppear(workspaceId: workspaceId)
        }
    }
}

private let weekdaysLocalized = {
    var calendar = Calendar.current
    calendar.locale = Locale.current  // 현재 리전에 맞게 설정

    let weekdaySymbols = calendar.weekdaySymbols  // 일 ~ 토 전체 요일 가져오기
    // 월요일부터 금요일까지만 잘라내기
    let mondayToFriday = Array(weekdaySymbols[1...5])

    return mondayToFriday
}()

private func weekdayRangeText(date: Date) -> String? {
    let calendar = Calendar.current
    
    // 현재 주의 월요일 계산
    guard let monday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
        return nil
    }
    
    // 현재 주의 금요일 계산
    guard let friday = calendar.date(byAdding: .day, value: 4, to: monday) else {
        return nil
    }
    
    return "\(monday.parseString("MM/dd")) ~ \(friday.parseString("MM/dd"))"
}
