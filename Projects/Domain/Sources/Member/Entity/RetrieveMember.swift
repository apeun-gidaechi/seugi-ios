import SwiftBok

@Init()
@Members()
public struct RetrieveMember: Entity, Equatable {
    public let id: Int
    public let email: String
    public let birth: String
    public let name: String
    public let picture: String
}
