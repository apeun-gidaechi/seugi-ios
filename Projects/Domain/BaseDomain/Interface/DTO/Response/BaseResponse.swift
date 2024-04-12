public struct BaseResponse<Data: Decodable>: Decodable {
    let status: Int
    let success: Bool
    let state: String
    let message: String
    let data: Data?
}
