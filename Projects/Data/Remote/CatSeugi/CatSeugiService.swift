import Foundation
import Domain

final class CatSeugiService: CatSeugiRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func sendMessage(_ req: CatSeugiSendMessageReq) -> APIResult<Base<String>> {
        runner.deepDive(CatSeugiEndpoint.sendMessage(req), res: Base<String>.self)
    }
}
