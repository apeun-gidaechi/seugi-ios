import SwiftBok

@PublicInit
public struct RetrieveMember: Entity, Equatable {
    let id: Int
    let email: String
    let birth: String
    let name: String
    let picture: String
}
