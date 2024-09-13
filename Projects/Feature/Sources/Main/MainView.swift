import SwiftUI
import Component
import DIContainer
import Domain
import Combine

public struct MainView: View {
    
    @EnvironmentObject private var appState: AppObservable
    @Router private var router
    @EnvironmentObject private var stompManager: StompManager
    @StateObject private var chatViewModel = ChatViewModel()
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    @StateObject private var homeViewModel = HomeViewModel()
    
    public init() {}
    
    private var isWorkspaceEmpty: Bool {
        if let workspaces = appState.workspaces.data,
           !workspaces.isEmpty {
            false
        } else {
            true
        }
    }
    
    private var tabs: [SeugiBottomNavigationCellData] {
        if isWorkspaceEmpty {
            [
                .init(type: .home, hasBadge: false)
            ]
        } else {
            [
                .init(type: .home, hasBadge: false),
                .init(type: .chat, hasBadge: false),
                .init(type: .room, hasBadge: false),
                .init(type: .notification, hasBadge: false),
                .init(type: .profile, hasBadge: false)
            ]
        }
    }
    
    private var homeFetchFlow: HomeFetchFlow {
        if appState.workspaces == .fetching {
            .fetching
        } else if isWorkspaceEmpty {
            .failure
        } else {
            .success
        }
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch appState.selectedMainTab {
                case .home: HomeView(flow: homeFetchFlow)
                case .chat: ChatView(roomType: .personal)
                case .room: ChatView(roomType: .group)
                case .notification: NotificationView()
                case .profile: ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .bottomGradientMask()
            if appState.workspaces != .fetching {
                SeugiBottomNavigation(selectedTab: $appState.selectedMainTab, tabs: tabs)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 400)
            }
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(chatViewModel)
        .environmentObject(homeViewModel)
        .onAppear {
            log("💎 MainView.body.onAppear")
            if case .fetching = appState.workspaces {
                appState.fetchWorkspaces()
            }
            stompManager.openSocket()
            appState.subscribe { subject in
                switch subject {
                case .workspaceFetched:
                    fetchAll()
                default:
                    break
                }
            }
        }
    }
    
    private func fetchAll() {
        fetchHome()
        fetchChats()
        fetchNotifications()
        fetchMyInfo()
    }
    
    private func fetchHome() {
        log("💎 MainView.fetchHome")
        guard let workspace = appState.selectedWorkspace else { return }
        homeViewModel.fetchMeals(workspaceId: workspace.workspaceId)
        homeViewModel.fetchTimetable(workspaceId: workspace.workspaceId)
    }
    
    private func fetchChats() {
        log("💎 MainView.fetchChats")
        guard let workspace = appState.selectedWorkspace else { return }
        chatViewModel.fetchChats(workspaceId: workspace.workspaceId)
    }
    
    private func fetchNotifications() {
        log("💎 MainView.fetchNotifications")
        guard let workspace = appState.selectedWorkspace else { return }
        notificationViewModel.fetchNotifications(workspaceId: workspace.workspaceId)
    }
    
    private func fetchMyInfo() {
        appState.fetchMyInfo()
    }
}
