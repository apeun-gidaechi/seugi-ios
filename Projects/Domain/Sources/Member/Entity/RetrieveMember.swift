public struct RetrieveMember: Entity, Hashable {
    public let id: Int
    public var email: String
    public var birth: String
    public var name: String
    public var picture: String?
    
    public init(
        id: Int,
        email: String,
        birth: String,
        name: String,
        picture: String?
    ) {
        self.id = id
        self.email = email
        self.birth = birth
        self.name = name
        self.picture = picture
    }
}

public extension RetrieveMember {
    static func invalidMember(id: Int) -> RetrieveMember {
        RetrieveMember(
            id: id,
            email: "",
            birth: "",
            name: "(알 수 없음)",
            picture: nil
        )
    }
    
    static func just(name: String) -> RetrieveMember {
        RetrieveMember(
            id: -1,
            email: "",
            birth: "",
            name: name,
            picture: nil
        )
    }
}
