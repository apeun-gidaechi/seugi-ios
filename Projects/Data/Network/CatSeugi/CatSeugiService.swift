//
//  CatSeugiService.swift
//  Network
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Domain

final class CatSeugiService: Service<CatSeugiEndpoint>, CatSeugiRepo {
    func sendMessage(_ req: CatSeugiSendMessageReq) -> APIResult<Base<String>> {
        performRequest(.sendMessage(req), res: String.self)
    }
}
