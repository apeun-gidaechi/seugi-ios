import Foundation
import RealmSwift
import Domain

final class RetrieveMemberEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var email: String
    @Persisted var birth: String
    @Persisted var name: String
    @Persisted var picture: String?
    
    convenience init(
        id: Int,
        email: String,
        birth: String,
        name: String,
        picture: String?
    ) {
        self.init()
        self.id = id
        self.email = email
        self.birth = birth
        self.name = name
        self.picture = picture
    }
    
    static func of(_ member: RetrieveMember) -> RetrieveMemberEntity {
        return RetrieveMemberEntity(
            id: member.id,
            email: member.email,
            birth: member.birth,
            name: member.name,
            picture: member.picture
        )
    }
    
    func toDomain() -> RetrieveMember {
        RetrieveMember(
            id: self.id,
            email: self.email,
            birth: self.birth,
            name: self.name,
            picture: self.picture
        )
    }
}
