import SwiftUI
import DIContainer
import SwiftUIUtil

struct WorkspaceDetailCoordinator: View {
    
    @Inject private var joinWorkspaceFactory: any JoinWorkspaceFactory
    @Inject private var createWorkspaceFactory: any CreateWorkspaceFactory
    
    var body: some View {
        WorkspaceDetailView()
            .navigationDestination(for: WorkspaceDetailDestination.self) {
                switch $0 {
                case .workspaceMembers: WorkspaceMembersView()
                case .createWorkspace: createWorkspaceFactory.makeView().eraseToAnyView()
                case .joinWorkspace: joinWorkspaceFactory.makeView().eraseToAnyView()
                case .manageMember: WorkspaceMemberView()
                case .invitationMember: InvitateMemberView()
                }
            }
    }
}
