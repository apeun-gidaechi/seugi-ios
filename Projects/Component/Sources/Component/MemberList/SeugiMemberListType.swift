import SwiftUI
import Domain

public enum SeugiMemberListType {
    case normal(member: RetrieveMember, isAdmin: Bool = false)
    case invitation
}
