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
        .project(target: target.rawValue,
                 path: .relativeToFeature(target.rawValue))
    }
    
    static func service(
        target: ModulePaths.Service
    ) -> TargetDependency {
        .project(target: target.rawValue,
                 path: .relativeToSerivce(target.rawValue))
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
}
