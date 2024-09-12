//
//  OAuthEndpoint.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Moya
import Domain

enum CatSeugiEndpoint: AIEndpoint {
    case sendMessage(CatSeugiSendMessageReq)
}

extension CatSeugiEndpoint {
    static let provider: MoyaProvider<Self> = .init(session: session)
    static var authProvider: MoyaProvider<Self> = provider
    
    var host: String {
        "ai"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .sendMessage(let req):
                .post - "" - req.toJSONParameters()
        }
    }
    
    var authorization: Authorization {
        .none
    }
}
