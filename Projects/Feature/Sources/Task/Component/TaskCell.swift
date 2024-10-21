import Foundation
import SwiftUI
import Component
import Domain
import DateUtil

struct TaskCell: View {
    private let title: String
    private let description: String
    private let dueDate: Date
    
    init(task: TaskEntity) {
        self.title = task.title
        self.description = task.description
        self.dueDate = task.dueDate
    }
    
    init(task: ClassroomTask) {
        self.title = task.title
        self.description = task.description
        self.dueDate = task.dueDate
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.body(.b1))
                    .seugiColor(.sub(.black))
                Text("D-\(dueDate.diff(endAt: .now, component: .day))")
                    .font(.caption(.c2))
                    .seugiColor(.sub(.white))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .cornerRadius(14, corners: .allCorners)
            }
            Text(description)
                .font(.body(.b2))
                .seugiColor(.gray(.g600))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
    }
}
