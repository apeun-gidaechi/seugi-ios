//
//  TargetDependency+Target.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension TargetDependency {
    static var diContainer: TargetDependency {
        .project(
            target: ModulePaths.Single.DIContainer.rawValue,
            path: .dIContainer
        )
    }
    
    static func feature(
        of target: ModulePaths.Feature,
        module: MicroFeatureModule = .Interface
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)Feature\(module.rawValue)",
            path: .relativeToFeature("\(target.rawValue)Feature")
        )
    }
    
    static var component: TargetDependency {
        .project(
            target: ModulePaths.Single.Component.rawValue,
            path: .component
        )
    }
    
    static var domain: TargetDependency {
        .project(
            target: ModulePaths.Single.Domain.rawValue,
            path: .domain
        )
    }
    
    static var domainTesting: TargetDependency {
        .project(
            target: "\(ModulePaths.Single.Domain.rawValue)Testing",
            path: .domain
        )
    }
    
    static func data(
        of target: ModulePaths.Data
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)",
            path: .data
        )
    }
    
    static func shared(
        of target: ModulePaths.Shared
    ) -> TargetDependency {
        .project(
            target: target.rawValue,
            path: .shared
        )
    }
}
