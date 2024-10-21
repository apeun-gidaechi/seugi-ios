import SwiftUI
import Component
import SwiftUIUtil

struct HomeView {
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @StateObject private var viewModel = HomeViewModel()
    
    private var isWorkspaceEmpty: Bool {
        mainViewModel.workspaces.data?.isEmpty ?? true
    }
    
    private var flow: HomeFetchFlow {
        if mainViewModel.workspaces.is(.fetching) {
            .fetching
        } else if isWorkspaceEmpty && mainViewModel.workspaces.is(.success) {
            .empty
        } else {
            .finished
        }
    }
}

extension HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HomeWorkspaceContainer(for: flow) {
                    router.navigate(to: MainDestination.workspaceDetail)
                }
                HomeTimetableContainer(for: viewModel.timetables)
                HomeMealContainer(for: viewModel.meals)
                HomeCatSeugiContainer(for: flow) { action in
                    switch action {
                    case .didClickedChat:
                        router.navigate(to: MainDestination.catSeugi)
                    }
                }
                HomeScheduleContainer(for: viewModel.schedules)
                HomeTaskContainer(for: viewModel.tasks) {
                    router.navigate(to: MainDestination.task)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 80)
            .padding(.horizontal, 20)
        }
        .refreshable {
            guard let id = mainViewModel.selectedWorkspace?.workspaceId else { return }
            self.viewModel.onAppear(workspaceId: id)
        }
        .scrollIndicators(.hidden)
        .seugiBackground(.primary(.p050))
        .seugiTopBar(
            title: "홈",
            colors: .default.copy(
                backgroundColor: .seugi(.primary(.p050))
            ),
            showBackButton: false
        )
        .animation(.spring(duration: 0.4), value: viewModel.meals)
        .animation(.spring(duration: 0.4), value: viewModel.timetables)
        .onChange(of: flow, initial: true) {
            if $0 == .empty {
                showJoinWorkspaceAlert()
            }
        }
        .onChange(of: mainViewModel.selectedWorkspace, initial: true) {
            guard let id = $0?.workspaceId else { return }
            viewModel.onAppear(workspaceId: id)
        }
    }
    
    func showJoinWorkspaceAlert() {
        alertProvider.present(
            .init(title: "학교 등록하기")
            .message("학교를 등록한 뒤 스기를 사용할 수 있어요")
            .primaryButton("기존 학교 가입") {
                router.navigate(to: MainDestination.joinWorkspaceRole)
            }
            .secondaryButton("새 학교 만들기") {
                router.navigate(to: MainDestination.createWorkspace)
            }
        )
    }
}
