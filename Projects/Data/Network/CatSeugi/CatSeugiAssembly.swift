//
//  CatSeugiAssembly.swift
//  Network
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Swinject
import Domain

public struct CatSeugiAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(CatSeugiRepo.self) { _ in
            CatSeugiService()
        }
    }
}
