import Foundation
import Domain
import Component

enum MainDestination: Hashable {
    // catseugi
    case catSeugi
    
    // chat
    case chatDetail(room: Room)
    case createGroupChatCoordinator
    
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
    case imagePreview(ImagePreview.Path)
    
    // task
    case task
    
    // meal
    case meal
}
