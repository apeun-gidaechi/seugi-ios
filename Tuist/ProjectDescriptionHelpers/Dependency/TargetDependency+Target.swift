//
//  TargetDependency+Target.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension TargetDependency {
    static func feature(
        target: ModulePaths.Feature
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)Feature",
                 path: .relativeToFeature("\(target.rawValue)Feature"))
    }
    
    static func featureInterface(
        target: ModulePaths.Feature
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)FeatureInterface",
                 path: .relativeToFeature("\(target.rawValue)Feature"))
    }
    
    static func domain(
        target: ModulePaths.Domain
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)Domain",
                 path: .relativeToDomain("\(target.rawValue)Domain"))
    }
    
    static func domainInterface(
        target: ModulePaths.Domain
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)DomainInterface",
                 path: .relativeToDomain("\(target.rawValue)Domain"))
    }
    
    static func userInterface(
        target: ModulePaths.UserInterface
    ) -> TargetDependency {
        .project(target: target.rawValue,
                 path: .relativeToUserInterface(target.rawValue))
    }
    
    static func shared(
        target: ModulePaths.Shared
    ) -> TargetDependency {
        .project(target: target.rawValue,
                 path: .relativeToShared(target.rawValue))
    }
    
    static func dIContainer(
        target: ModulePaths.DIContainer
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)",
                 path: .dIContainer)
    }
    
    static func dIContainerInterface(
        target: ModulePaths.DIContainer
    ) -> TargetDependency {
        .project(target: "\(target.rawValue)Interface",
                 path: .dIContainer)
    }
}
