import SwiftUI

public struct SeugiBottomNavigationData: Hashable {
    public let cellData: [SeugiBottomNavigationCellData]
    public let selectedTab: SeugiBottomNavigationType
    
    public init(
        cellData: [SeugiBottomNavigationCellData],
        selectedTab: SeugiBottomNavigationType
    ) {
        self.cellData = cellData
        self.selectedTab = selectedTab
    }
}

public struct SeugiBottomNavigationCellData: Hashable {
    public let type: SeugiBottomNavigationType
    public let hasBadge: Bool
    
    public init(
        type: SeugiBottomNavigationType,
        hasBadge: Bool
    ) {
        self.type = type
        self.hasBadge = hasBadge
    }
}

@frozen
public enum SeugiBottomNavigationType: CaseIterable {
    case home
    case chat
    case room
    case notification
    case profile
    
    var text: String {
        switch self {
        case .home: "홈"
        case .chat: "채팅"
        case .room: "단체"
        case .notification: "공지"
        case .profile: "프로필"
        }
    }
    
    var image: SeugiIconography {
        switch self {
        case .home: .homeFill
        case .chat: .chatFill
        case .room: .peopleFill
        case .notification: .notificationFill
        case .profile: .personFill
        }
    }
}
