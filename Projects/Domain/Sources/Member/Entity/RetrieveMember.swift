public struct RetrieveMember: Entity, Hashable {
    public let id: Int
    public let email: String
    public let birth: String
    public let name: String
    public let picture: String
    
    public init(id: Int, email: String, birth: String, name: String, picture: String) {
        self.id = id
        self.email = email
        self.birth = birth
        self.name = name
        self.picture = picture
    }
}
