//
//  OAuthEndpoint.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Moya
import Domain

enum OAuthEndpoint: SeugiEndpoint {
    case authenticateGoogle(GoogleCodeReq)
    case connectGoogle(GoogleCodeReq)
}

extension OAuthEndpoint {
    static let authProvider: MoyaProvider<Self> = .init(session: session)
    static let provider: MoyaProvider<Self> = .init(session: authSession)
    
    var host: String {
        "oauth"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .authenticateGoogle(let req):
                .post - "google/authenticate" - req.toJSONParameters()
        case .connectGoogle(let req):
                .post - "google/connect" - req.toJSONParameters()
        }
    }
}

