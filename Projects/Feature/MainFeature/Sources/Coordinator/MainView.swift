import SwiftUI
import BaseFeatureInterface
import Component
import HomeFeatureInterface
import ChatFeatureInterface
import ChatDetailFeatureInterface
import CreateRoomFeatureInterface
import NotificationFeatureInterface
import ProfileFeatureInterface
import NotificationFeatureInterface
import DIContainer
import Domain
import Combine

public struct MainView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var stompManager: StompManager
    @State private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Factory
    @Inject private var emptyHomeFactory: any EmptyHomeFactory
    @Inject private var progressHomeFactory: any ProgressHomeFactory
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
        NavigationStack(path: $router.navPath) {
            content
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
    @ViewBuilder
    private var content: some View {
        ZStack {
            if appState.workspaces == .fetching {
                progressHomeFactory.makeView().eraseToAnyView()
            } else if isWorkspaceEmpty {
                emptyHomeFactory.makeView().eraseToAnyView()
            } else {
                switch appState.selectedMainTab {
                case .home: homeFactory.makeView().eraseToAnyView()
                case .chat: chatFactory.makeView(roomType: .personal).eraseToAnyView()
                case .room: chatFactory.makeView(roomType: .group).eraseToAnyView()
                case .notification: notificationFactory.makeView().eraseToAnyView()
                case .profile: profileFactory.makeView().eraseToAnyView()
                }
            }
            if appState.workspaces != .fetching {
                GeometryReader { reader in
                    ZStack(alignment: .bottom) {
                        SeugiBottomNavigation(selectedTab: $appState.selectedMainTab, tabs: tabs)
                            .shadow(color: Color.black.opacity(0.04), radius: 12)
                        VStack {
                            Spacer()
                            Color.white
                                .frame(height: reader.safeAreaInsets.bottom, alignment: .bottom)
                        }
                        .ignoresSafeArea()
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(chatViewModel)
        .environmentObject(notificationViewModel)
        .onAppear {
            print("💎 MainView.body.onAppear")
            appState.fetchWorkspaces()
            stompManager.subscribe()
            appState.subscribe { subject in
                switch subject {
                case .workspaceFetched:
                    fetchAll()
                }
            }
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
