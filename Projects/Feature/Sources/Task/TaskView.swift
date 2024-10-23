import SwiftUI
import Component

struct TaskView {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @StateObject private var viewModel = TaskViewModel()
}

extension TaskView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                Text("구글 클래스룸 과제")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.leading, 4)
                    viewModel.classroomTasks.makeView {
                        ProgressView()
                    } success: { tasks in
                        if tasks.isEmpty {
                            Text("과제가 없어요")
                                .padding(.vertical, 20)
                                .font(.body(.b2))
                                .seugiColor(.sub(.black))
                        } else {
                            ForEach(tasks, id: \.id) { task in
                                TaskCell(task: task)
                            }
                        }
                    } failure: { _ in
                        Text("과제가 없어요")
                            .padding(.vertical, 20)
                            .font(.body(.b2))
                            .seugiColor(.sub(.black))
                    }
                Text("일반 과제")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                    .padding(.leading, 4)
                viewModel.tasks.makeView {
                    ProgressView()
                } success: { tasks in
                    if tasks.isEmpty {
                        Text("과제가 없어요")
                            .padding(.vertical, 20)
                            .font(.body(.b2))
                            .seugiColor(.sub(.black))
                    } else {
                        ForEach(tasks, id: \.id) { task in
                            TaskCell(task: task)
                        }
                    }
                } failure: { _ in
                    Text("과제가 없어요")
                        .padding(.vertical, 20)
                        .font(.body(.b2))
                        .seugiColor(.sub(.black))
                }
            }
            .padding(.horizontal, 20)
        }
        .seugiTopBar(
            title: "과제",
            colors: .init(
                backgroundColor: .seugi(.primary(.p050))
            )
        )
        .onAppear {
            guard let id = mainViewModel.selectedWorkspace?.workspaceId else { return }
            viewModel.onCreate(workspaceId: id)
        }
    }
}
