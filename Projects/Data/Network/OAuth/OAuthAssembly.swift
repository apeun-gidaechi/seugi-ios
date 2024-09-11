//
//  OAuthAssembly.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Swinject
import Domain

public struct OAuthAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(OAuthRepo.self) { _ in
            OAuthService()
        }
    }
}
