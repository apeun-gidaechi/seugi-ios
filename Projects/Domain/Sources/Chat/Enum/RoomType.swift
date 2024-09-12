public enum RoomType: String, CaseIterable, Decodable {
    case personal = "PERSONAL"
    case group = "GROUP"
    
    public var text: String {
        switch self {
        case .personal: "채팅"
        case .group: "그룹"
        }
    }
}
