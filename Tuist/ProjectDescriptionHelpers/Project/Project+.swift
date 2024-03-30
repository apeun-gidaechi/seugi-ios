//
//  Project+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/29/24.
//

import ProjectDescription

public extension Project {
    static func makeApp(
        target: ModulePaths.App,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(
            name: target.rawValue,
            product: .app,
            packages: packages,
            targets: targets
        )
    }
    
    static func makeFeature(
        target: ModulePaths.Feature,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: target.rawValue,
                    product: .staticLibrary,
                    targets: targets)
    }
    
    static func makeService(
        target: ModulePaths.Service,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: target.rawValue,
                    product: .staticLibrary,
                    targets: targets)
    }
    
    static func makeShared(
        target: ModulePaths.Shared,
        packages: [Package] = [],
        targets: [Target]
    ) -> Self {
        .makeProject(name: target.rawValue,
                    product: .staticLibrary,
                    targets: targets)
    }
    
    static func makeUserInterface(
        target: ModulePaths.UserInterface,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: target.rawValue,
                    product: .staticFramework,
                    targets: targets)
    }
}
