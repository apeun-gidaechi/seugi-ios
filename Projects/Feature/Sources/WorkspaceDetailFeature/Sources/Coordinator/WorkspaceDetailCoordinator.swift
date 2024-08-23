import SwiftUI
import DIContainer
import SwiftUIUtil

struct WorkspaceDetailCoordinator: View {
    
    var body: some View {
        WorkspaceDetailView()
            .navigationDestination(for: WorkspaceDetailDestination.self) {
                switch $0 {
                case .workspaceMembers: WorkspaceMembersView()
                case .createWorkspace: CreateWorkspaceCoordinator()
                case .joinWorkspace: JoinWorkspaceCoordinator()
                case .manageMember: WorkspaceMemberView()
                case .invitationMember: InvitateMemberView()
                }
            }
    }
}
