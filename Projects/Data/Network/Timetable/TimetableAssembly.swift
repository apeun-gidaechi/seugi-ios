//
//  TimetableAssembly.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Domain
import Swinject

public final class TimetableAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(TimetableRepo.self) { _ in
            TimetableService()
        }
    }
}
