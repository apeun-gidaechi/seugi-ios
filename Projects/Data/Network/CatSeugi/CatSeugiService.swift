import Foundation

import Domain

final class CatSeugiService: Service<CatSeugiEndpoint>, CatSeugiRepo {
    func sendMessage(_ req: CatSeugiSendMessageReq) -> APIResult<Base<String>> {
        performRequest(.sendMessage(req), res: String.self)
    }
}
