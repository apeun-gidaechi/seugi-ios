import SwiftUI
import Component
import Domain
import DateUtil
import ScopeKit

struct HomeTaskContainer: View {
    private let tasks: Flow<[TaskEntity]>
    private let action: () -> Void
    
    init(
        for tasks: Flow<[TaskEntity]>,
        action: @escaping () -> Void
    ) {
        self.tasks = tasks
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: action) {
                HStack(spacing: 8) {
                    HomeHeadlineIcon(icon: .calendarLine)
                    Text("다가오는 과제")
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
            }
            .scaledButtonStyle()
            tasks.makeView {
                ProgressView()
            } success: { tasks in
                if tasks.isEmpty {
                    SeugiError("일정이 없어요", image: .sadButRelievedFace)
                } else {
                    VStack(spacing: 16) {
                        ForEach(tasks, id: \.id) { task in
                            HStack(spacing: 0) {
                                Text(run {
                                    if let dueDate = task.dueDate {
                                        dueDate.parseString("MM/dd")
                                    } else {
                                        "기한없음"
                                    }
                                })
                                .font(.body(.b1))
                                .seugiColor(.primary(.p500))
                                Text(task.title)
                                    .font(.body(.b2))
                                    .seugiColor(.sub(.black))
                                    .padding(.leading, 10)
                                    .lineLimit(1)
                                Spacer()
                                Text(run {
                                    if let dueDate = task.dueDate {
                                        "D-\(dueDate.diff(endAt: .now, component: .day))"
                                    } else {
                                        "기한없음"
                                    }
                                })
                                .font(.caption(.c1))
                                .seugiColor(.gray(.g600))
                            }
                        }
                    }
                }
            } failure: { _ in
                Text("과제를 불러올 수 없어요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            }
        }
        .applyCardEffect()
    }
}
