import Foundation

public protocol CatSeugiRepo {
    func sendMessage(_ req: CatSeugiSendMessageReq) -> APIResult<Base<String>>
}
