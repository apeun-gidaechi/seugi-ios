import Foundation

public protocol MessageRepo {
    func getMessages(roomId: String, page: Int, size: Int) -> APIResult<Base<GetMessage>>
}
