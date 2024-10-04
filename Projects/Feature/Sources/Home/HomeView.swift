import SwiftUI
import Component
import SwiftUIUtil

public struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    private var isWorkspaceEmpty: Bool {
        if let workspaces = appState.workspaces.data,
           !workspaces.isEmpty {
            false
        } else {
            true
        }
    }
    
    private var flow: HomeFetchFlow {
        if appState.workspaces.is(.fetching) {
            .fetching
        } else if isWorkspaceEmpty {
            .failure
        } else {
            .success
        }
    }
    
    public init() {}
    
    private func showJoinWorkspaceAlert() {
        alertProvider.present("학교 등록하기")
            .primaryButton("기존 학교 가입") {
                router.navigate(to: MainDestination.joinWorkspaceRole)
            }
            .secondaryButton("새 학교 만들기") {
                router.navigate(to: MainDestination.createWorkspace)
            }
            .message("학교를 등록한 뒤 스기를 사용할 수 있어요")
            .show()
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HomeWorkspaceContainer(for: flow)
                    .button {
                        router.navigate(to: MainDestination.workspaceDetail)
                    }
                    .applyAnimation()
                HomeTimetableContainer(for: viewModel.timetables)
                HomeMealContainer(for: viewModel.meals)
                HomeCatSeugiContainer(for: flow) { action in
                    switch action {
                    case .clicked:
                        router.navigate(to: MainDestination.catSeugi)
                    }
                }
                HomeScheduleContainer(for: flow)
            }
            .padding(.top, 8)
            .padding(.bottom, 80)
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .seugiBackground(.primary(.p050))
        .seugiTopBar("홈", background: .seugi(.primary(.p050)))
        .hideBackButton()
        .animation(.spring(duration: 0.4), value: viewModel.meals)
        .animation(.spring(duration: 0.4), value: viewModel.timetables)
        .onChange(of: flow, initial: true) {
            if $0 == .failure {
                showJoinWorkspaceAlert()
            }
        }
        .onReceive(appState.$selectedWorkspace) {
            guard let id = $0?.workspaceId else { return }
            viewModel.fetchMeals(workspaceId: id)
            viewModel.fetchTimetable(workspaceId: id)
        }
    }
}
