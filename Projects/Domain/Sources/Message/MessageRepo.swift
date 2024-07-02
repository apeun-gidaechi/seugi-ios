import Foundation

public protocol MessageRepo {
    func getMessages() -> APIResult<[GetMessage]>
}
