import Domain

struct RetrieveMemberRes: Decodable, EntityMappable {
    let id: Int
    let email: String
    let birth: String
    let name: String
    let picture: String
    
    func toEntity() -> RetrieveMember {
        RetrieveMember(
            id: id,
            email: email,
            birth: birth,
            name: name,
            picture: picture
        )
    }
}