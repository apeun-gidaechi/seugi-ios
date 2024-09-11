//
//  OAuthRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public protocol OAuthRepo {
    func authenticateGoogle(_ req: GoogleCodeReq) -> APIResult<Base<Token>>
    func connectGoogle(_ req: GoogleCodeReq) -> APIResult<BaseVoid>
}
