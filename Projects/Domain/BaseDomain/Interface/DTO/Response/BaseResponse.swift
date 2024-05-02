public struct BaseResponse<Data: Decodable>: Decodable {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
    public let data: Data
}

public struct BaseVoidResponse: Decodable {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
}


