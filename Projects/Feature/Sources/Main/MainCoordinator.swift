//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by hhhello0507 on 8/22/24.
//

import SwiftUI
import DIContainer

struct MainCoordinator: View {
    
    var body: some View {
        MainView()
            .navigationDestination(for: MainDestination.self) { destination in
                switch destination {
                    
                    // chat
                case .chatDetail(let room): ChatDetailView(room: room)
                case .firstCreateGroupChat: FirstCreateGroupChatView()
                case .secondCreateGroupChat: SecondCreateGroupChatView()
                    
                    // notification
                case .createNotification: PostNotificationView(type: .createNotification)
                case .updateNotification(let notification): PostNotificationView(type: .updateNotification(notification))
                    
                    // profile
                case .settingProfile: SettingProfileView()
                    
                    // workspace detail
                case .workspaceDetail: WorkspaceDetailView()
                case .workspaceMembers: WorkspaceMemberView()
                case .createWorkspace: CreateWorkspaceView()
                case .manageMember: WorkspaceMemberView()
                case .invitationMember: InvitateMemberView()
                    
                    // join workspace
                case .joinWorkspaceCode: JoinWorkspaceCodeView()
                case .joinWorkspaceFinish: JoinWorkspaceRoleView()
                case .joinWorkspaceSuccess: JoinWorkspaceSuccessView()
                case .joinWorkspaceRole: JoinWorkspaceRoleView()
                }
            }
    }
}
