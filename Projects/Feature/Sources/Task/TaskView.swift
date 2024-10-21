import SwiftUI
import Component

struct TaskView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @StateObject private var viewModel = TaskViewModel()
}

extension TaskView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text("구글 클래스룸 과제")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.leading, 4)
                viewModel.tasks.makeView {
                    ProgressView()
                } success: { tasks in
                    ForEach(tasks, id: \.id) { task in
                        TaskCell(task: task)
                    }
                } failure: { _ in }
                Text("일반 과제")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                    .padding(.leading, 4)
                viewModel.classroomTasks.makeView {
                    ProgressView()
                } success: { tasks in
                    ForEach(tasks, id: \.id) { task in
                        TaskCell(task: task)
                    }
                } failure: { _ in }
            }
            .padding(.horizontal, 20)
        }
        .seugiTopBar(title: "과제")
        .onAppear {
            guard let id = mainViewModel.selectedWorkspace?.workspaceId else { return }
            viewModel.onCreate(workspaceId: id)
        }
    }
}
