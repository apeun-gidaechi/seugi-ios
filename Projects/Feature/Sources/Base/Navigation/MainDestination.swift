//
//  MainDestination.swift
//  Feature
//
//  Created by hhhello0507 on 8/23/24.
//

import Foundation
import Domain

public enum MainDestination: Hashable {
    
    // catseugi
    case catSeugi
    
    // chat
    case chatDetail(room: Room)
    case firstCreateGroupChat
    case secondCreateGroupChat
    
    // notification
    case createNotification
    case updateNotification(Domain.Notification)
    
    // profile
    case settingProfile
    
    // workspace detail
    case workspaceDetail
    case workspaceMembers
    case createWorkspace
    case settingGeneral
    case settingAlarm
    case manageMember
    case invitationMember
    
    // join workspace
    case joinWorkspaceCode
    case joinWorkspaceFinish
    case joinWorkspaceSuccess
    case joinWorkspaceRole
    
    // preview
    case imagePreview(URL)
}
