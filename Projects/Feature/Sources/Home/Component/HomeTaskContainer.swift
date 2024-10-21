import SwiftUI
import Component
import Domain
import DateUtil
import ScopeKit

struct HomeTaskContainer: View {
    
    private let tasks: Flow<[Domain.Task]>
    
    init(for tasks: Flow<[Domain.Task]>) {
        self.tasks = tasks
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
            tasks.makeView {
                ProgressView()
            } success: { tasks in
                if tasks.isEmpty {
                    SeugiError("일정이 없어요", image: .sadButRelievedFace)
                } else {
                    VStack(spacing: 16) {
                        ForEach(tasks, id: \.id) { task in
                            HStack(spacing: 0) {
                                Text(task.dueDate.parseString("MM/dd"))
                                    .font(.body(.b1))
                                    .seugiColor(.primary(.p500))
                                Text(task.title)
                                    .font(.body(.b2))
                                    .seugiColor(.sub(.black))
                                    .padding(.leading, 10)
                                Spacer()
                                Text("D-\(task.dueDate.diff(component: .day))")
                                    .font(.caption(.c1))
                                    .seugiColor(.gray(.g600))
                            }
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
