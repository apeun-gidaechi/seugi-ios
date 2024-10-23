import Foundation

public protocol CatSeugiRepo {
    func sendMessage(_ req: SendMessageReq) -> APIResult<Base<String>>
}
