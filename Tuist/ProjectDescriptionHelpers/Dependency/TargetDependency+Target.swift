//
//  TargetDependency+Target.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension TargetDependency {
    static func feature(
        _ module: MicroModule,
        for target: ModulePaths.Feature
    ) -> TargetDependency {
        .project(
            target: "\(target)Feature\(module)",
            path: .relativeToFeature("\(target)Feature\(module)")
        )
    }
    
    static func domain(
        _ module: MicroModule,
        for target: ModulePaths.Domain
    ) -> TargetDependency {
        .project(
            target: "\(target)Domain\(module)",
            path: .relativeToDomain("\(target)Domain\(module)")
        )
    }
    
    static func userInterface(
        _ module: MicroModule,
        for target: ModulePaths.UserInterface
    ) -> TargetDependency {
        .project(
            target: "\(target)\(target)",
            path: .relativeToUserInterface("\(target)\(module)")
        )
    }
    
    static func shared(
        _ module: MicroModule,
        for target: ModulePaths.Shared
    ) -> TargetDependency {
        .project(
            target: "\(target)\(module)",
            path: .relativeToShared("\(target)\(module)")
        )
    }
    
    static func dIContainer(
        _ module: MicroModule,
        for target: ModulePaths.DIContainer
    ) -> TargetDependency {
        .project(
            target: "\(target)\(module)",
            path: .dIContainer
        )
    }
}
