import SwiftUI
import Component
import DIContainer
import Domain
import Combine

public struct MainView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var stompManager: StompManager
    
    // MARK: - Factory
    @Inject private var stompRepo: any StompRepo

    // MARK: - ViewModel
    @StateObject private var chatViewModel = ChatViewModel()
    @StateObject private var notificationViewModel = NotificationViewModel()
    
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
    
    // TODO: Devide methods by viewModel
    private func fetchAll() {
        fetchChats()
        fetchNotifications()
        fetchMyInfo()
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
        .environmentObject(notificationViewModel)
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
        .onChange(of: appState.selectedWorkspace) { _ in
            fetchAll()
        }
    }
}