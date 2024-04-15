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
            packages: packages,
            targets: targets
        )
    }
    
    static func makeFeature(
        target: ModulePaths.Feature,
        packages: [Package] = [],
        include: Set<MicroModule> = [],
        interfaceDependency: [TargetDependency] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = [],
        exampleDependency: [TargetDependency] = []
    ) -> Self {
        var targets: [Target] = []
        
        if include.contains(.Interface) {
            targets.append(.feature(target: target, type: .Interface, dependencies: interfaceDependency))
        }
        
        if include.contains(.Feature) {
            targets.append(.feature(target: target, type: .Feature, dependencies: featureDependency))
        }
        
        if include.contains(.Testing) {
            targets.append(.feature(target: target, type: .Testing, dependencies: testingDependency))
        }
        
        if include.contains(.Tests) {
            targets.append(.feature(target: target, type: .Tests, dependencies: testsDependency))
        }
        
        if include.contains(.Example) {
            
            let infoPlist = InfoPlist.extendingDefault(with: [
                "UIUserInterfaceStyle":"Light",
                "LSRequiresIPhoneOS":.boolean(true),
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": .boolean(false)
                ],
                "UILaunchStoryboardName": .string("")
            ])
            let target = Target.feature(target: target, type: .Example, infoPlist: infoPlist, dependencies: exampleDependency)
            
            targets.append(target)
        }
        
        return .makeProject(
            name: "\(target.rawValue)Feature",
            targets: targets
        )
    }
    
    static func makeDomain(
        target: ModulePaths.Domain,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: "\(target.rawValue)Domain",
                    targets: targets)
    }
    
    static func makeShared(
        target: ModulePaths.Shared,
        packages: [Package] = [],
        targets: [Target]
    ) -> Self {
        .makeProject(name: target.rawValue,
                    targets: targets)
    }
    
    static func makeUserInterface(
        target: ModulePaths.UserInterface,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: target.rawValue,
                    targets: targets)
    }
    
    static func makeDIContainer(
        target: ModulePaths.DIContainer,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(name: target.rawValue,
                    targets: targets)
    }
}
