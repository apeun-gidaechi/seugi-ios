//
//  OAuthService.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Domain

final class OAuthService: Service<OAuthEndpoint>, OAuthRepo {
    func authenticateGoogle(_ req: GoogleCodeReq) -> ObservableResult<Base<Token>> {
        performRequest(.authenticateGoogle(req), res: Token.self)
    }
    
    func connectGoogle(_ req: GoogleCodeReq) -> ObservableResult<BaseVoid> {
        performRequest(.connectGoogle(req))
    }
}
