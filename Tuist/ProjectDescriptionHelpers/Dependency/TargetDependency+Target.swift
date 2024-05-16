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
            target: "\(target.rawValue)Feature\(module.rawValue)",
            path: .relativeToFeature("\(target.rawValue)Feature")
        )
    }
    
    static func domain(
        _ module: MicroModule,
        for target: ModulePaths.Domain
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)Domain\(module.rawValue)",
            path: .relativeToDomain("\(target.rawValue)Domain")
        )
    }
    
    static func core(
        _ module: MicroModule,
        for target: ModulePaths.Core
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)\(module.rawValue)",
            path: .relativeToCore("\(target.rawValue)")
        )
    }
    
    static func userInterface(
        _ module: MicroModule,
        for target: ModulePaths.UserInterface
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)\(module.rawValue)",
            path: .relativeToUserInterface("\(target.rawValue)")
        )
    }
    
    static func shared(
        _ module: MicroModule,
        for target: ModulePaths.Shared
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)\(module.rawValue)",
            path: .relativeToShared("\(target.rawValue)")
        )
    }
    
    static func dIContainer(
        _ module: MicroModule,
        for target: ModulePaths.DIContainer
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)\(module.rawValue)",
            path: .dIContainer
        )
    }
}
