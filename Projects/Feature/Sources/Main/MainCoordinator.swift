import SwiftUI

struct MainCoordinator: View {
    @StateObject private var joinWorkspaceViewModel = JoinWorkspaceViewModel()
    @StateObject private var notificationViewModel = NotificationViewModel()
    
    var body: some View {
        MainView()
            .environmentObject(notificationViewModel)
            .navigationDestination(for: MainDestination.self) { destination in
                switch destination {
                    // catSeugi
                case .catSeugi: CatSeugiView()
                    
                    // chat
                case .chatDetail(let room): ChatDetailView(room: room)
                case .createGroupChatCoordinator: CreateGroupChatCoordinator()
                    
                    // notification
                case .createNotification:
                    PostNotificationView(type: .createNotification).environmentObject(notificationViewModel)
                case .updateNotification(let notification):
                    PostNotificationView(type: .updateNotification(notification)).environmentObject(notificationViewModel)
                    
                    // profile
                case .settingProfile: SettingProfileView()
                    
                    // workspace detail
                case .workspaceDetail: WorkspaceDetailView()
                case .workspaceMembers: WorkspaceMemberView()
                case .createWorkspace: CreateWorkspaceView()
                case .settingGeneral: SettingGeneralView()
                case .settingAlarm: SettingAlarmView()
                case .manageMember: WorkspaceMemberView()
                case .invitationMember: InvitateMemberView()
                    
                    // join workspace
                case .joinWorkspaceCode: JoinWorkspaceCodeView().environmentObject(joinWorkspaceViewModel)
                case .joinWorkspaceFinish: JoinWorkspaceRoleView().environmentObject(joinWorkspaceViewModel)
                case .joinWorkspaceSuccess: JoinWorkspaceSuccessView().environmentObject(joinWorkspaceViewModel)
                case .joinWorkspaceRole: JoinWorkspaceRoleView().environmentObject(joinWorkspaceViewModel)
                    
                    // preview
                case .imagePreview(let url): ImagePreview(url: url)
                }
            }
    }
}
