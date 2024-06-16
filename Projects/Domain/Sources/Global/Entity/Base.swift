import PublicInit

@PublicInit
public struct Base<Data: Entity>: Entity {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
    public let data: Data
}

@PublicInit
public struct BaseVoid: Entity, Equatable {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
}
