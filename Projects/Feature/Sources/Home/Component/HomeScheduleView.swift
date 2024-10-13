import SwiftUI
import Component
import Domain

struct HomeScheduleContainer: View {
    
    private let schedule: Flow<[Schedule]>
    
    init(for schedule: Flow<[Schedule]>) {
        self.schedule = schedule
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                HomeHeadlineIcon(icon: .calendarLine)
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
            schedule.makeView {
                ProgressView()
            } success: { schedules in
                VStack(spacing: 16) {
                    ForEach(schedules, id: \.id) { schedule in
                        HStack(spacing: 0) {
                            Text(schedule.date.parseString("MM/dd"))
                                .font(.body(.b1))
                                .seugiColor(.primary(.p500))
                            Text(schedule.eventName)
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
            } failure: { _ in
                Text("학교를 등록하고 일정을 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            }
        }
        .applyCardEffect()
    }
}
