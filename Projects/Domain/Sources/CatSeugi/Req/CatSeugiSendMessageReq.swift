import Foundation

public struct CatSeugiSendMessageReq: Encodable {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
}
