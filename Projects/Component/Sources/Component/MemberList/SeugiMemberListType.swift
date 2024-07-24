import SwiftUI
import Domain

public enum SeugiMemberListType {
    case normal(member: RetrieveMember, role: WorkspaceRole? = nil)
    case invitation
}
