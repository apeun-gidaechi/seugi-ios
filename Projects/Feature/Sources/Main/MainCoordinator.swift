//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by hhhello0507 on 8/22/24.
//

import SwiftUI

struct MainCoordinator: View {
    
    @StateObject private var joinWorkspaceViewModel = JoinWorkspaceViewModel()
    @StateObject private var createGroupChatViewModel = CreateGroupChatViewModel()
    
    var body: some View {
        MainView()
            .navigationDestination(for: MainDestination.self) { destination in
                switch destination {
                    // catSeugi
                case .catSeugi: CatSeugiView()
                    
                    // chat
                case .chatDetail(let room): ChatDetailView(room: room)
                case .firstCreateGroupChat: FirstCreateGroupChatView().environmentObject(createGroupChatViewModel)
                case .secondCreateGroupChat: SecondCreateGroupChatView().environmentObject(createGroupChatViewModel)
                    
                    // notification
                case .createNotification: 
                    PostNotificationView(type: .createNotification)
                case .updateNotification(let notification):
                    PostNotificationView(type: .updateNotification(notification))
                    
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
                }
            }
    }
}
