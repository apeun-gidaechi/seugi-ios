import SwiftUI
import BaseFeatureInterface
import Component
import HomeFeatureInterface
import ChatFeatureInterface
import ChatDetailFeatureInterface
import CreateGroupChatFeatureInterface
import NotificationFeatureInterface
import ProfileFeatureInterface
import DIContainer
import Domain
import Combine

public struct MainView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var stompManager: StompManager
    @State private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Factory
    @Inject private var homeFactory: any HomeFactory
    @Inject private var chatFactory: any ChatFactory
    @Inject private var notificationFactory: any NotificationFactory
    @Inject private var profileFactory: any ProfileFactory
    @Inject private var stompRepo: any StompRepo

    // MARK: - ViewModel
    @InjectObject private var chatViewModel: ChatViewModel
    @InjectObject private var notificationViewModel: NotificationViewModel
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch appState.selectedMainTab {
                case .home: homeFactory.makeView(flow: homeFetchFlow).eraseToAnyView()
                case .chat: chatFactory.makeView(roomType: .personal).eraseToAnyView()
                case .room: chatFactory.makeView(roomType: .group).eraseToAnyView()
                case .notification: notificationFactory.makeView().eraseToAnyView()
                case .profile: profileFactory.makeView().eraseToAnyView()
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
            print("💎 MainView.body.onAppear")
            if case .fetching = appState.workspaces {
                appState.fetchWorkspaces()
            }
            stompManager.subscribe()
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
    
    // TODO: Devide methods by viewModel -
    private func fetchAll() {
        fetchChats()
        fetchNotices()
        fetchMyInfo()
    }
    
    private func fetchChats() {
        print("💎 MainView.fetchChats")
        guard let workspace = appState.selectedWorkspace else { return }
        chatViewModel.fetchChats(workspaceId: workspace.workspaceId)
    }
    
    private func fetchNotices() {
        print("💎 MainView.fetchNotices")
        guard let workspace = appState.selectedWorkspace else { return }
        notificationViewModel.fetchNotices(workspaceId: workspace.workspaceId)
    }
    
    private func fetchMyInfo() {
        appState.fetchMyInfo()
    }
}
