//
//  Project+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/29/24.
//

import ProjectDescription

public extension Project {
    static func makeApp(
        packages: [Package] = [],
        targets: [Target] = [],
        xcconfig: Path? = nil
    ) -> Self {
        .makeProject(
            name: "Seugi",
            packages: packages,
            xcconfig: xcconfig, 
            targets: targets
        )
    }
    
    static func makeFeature(
        type: ModulePaths.Feature,
        packages: [Package] = [],
        include: Set<MicroModule>,
        additionalTarget: [Target] = [],
        interfaceDependency: [TargetDependency] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = [],
        exampleDependency: [TargetDependency] = []
    ) -> Self {
        var targets = additionalTarget
        
        if include.contains(.Interface) {
            targets.append(.feature(target: type, type: .Interface, dependencies: interfaceDependency))
        }
        
        if include.contains(.Feature) {
            targets.append(.feature(target: type, type: .Feature, dependencies: featureDependency + [
                .feature(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Testing) {
            targets.append(.feature(target: type, type: .Testing, dependencies: testingDependency + [
                .feature(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.feature(target: type, type: .Tests, dependencies: testsDependency + [
                .feature(.Feature, for: type),
                .feature(.Testing, for: type)
            ]))
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
            let target = Target.feature(target: type, type: .Example, infoPlist: infoPlist, dependencies: exampleDependency + [
                .feature(.Feature, for: type)
            ])
            
            targets.append(target)
        }
        
        return .makeProject(
            name: "\(type.rawValue)Feature",
            targets: targets
        )
    }
    
    static func makeDomain(
        type: ModulePaths.Domain,
        packages: [Package] = [],
        include: Set<MicroModule>,
        additionalTarget: [Target] = [],
        interfaceDependency: [TargetDependency] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = []
    ) -> Self {
        
        var targets = additionalTarget
        
        if include.contains(.Interface) {
            targets.append(.domain(target: type, type: .Interface, dependencies: interfaceDependency))
        }
        
        if include.contains(.Feature) {
            targets.append(.domain(target: type, type: .Feature, dependencies: featureDependency + [
                .domain(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Testing) {
            targets.append(.domain(target: type, type: .Testing, dependencies: testingDependency + [
                .domain(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.domain(target: type, type: .Tests, dependencies: testsDependency + [
                .domain(.Feature, for: type),
                .domain(.Testing, for: type)
            ]))
        }
        
        return .makeProject(
            name: "\(type.rawValue)Domain",
            targets: targets
        )
    }
    
    static func makeShared(
        type: ModulePaths.Shared,
        packages: [Package] = [],
        include: Set<MicroModule>,
        additionalTarget: [Target] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = []
    ) -> Self {
        
        var targets = additionalTarget
        
        if include.contains(.Feature) {
            targets.append(.shared(target: type, type: .Feature, dependencies: featureDependency))
        }
        
        if include.contains(.Testing) {
            targets.append(.shared(target: type, type: .Testing, dependencies: testingDependency + [
                .shared(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.shared(target: type, type: .Tests, dependencies: testsDependency + [
                .shared(.Feature, for: type),
                .shared(.Testing, for: type)
            ]))
        }
        
        return .makeProject(
            name: type.rawValue,
            targets: targets
        )
    }
    
    static func makeUserInterface(
        type: ModulePaths.UserInterface,
        packages: [Package] = [],
        include: Set<MicroModule>,
        additionalTarget: [Target] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = [],
        exampleDependency: [TargetDependency] = []
    ) -> Self {
        var targets = additionalTarget
        
        if include.contains(.Feature) {
            targets.append(
                .userInterface(
                    target: type,
                    type: .Feature,
                    resources: ["Resources/**"],
                    dependencies: featureDependency
                )
            )
        }
        
        if include.contains(.Testing) {
            targets.append(.userInterface(target: type, type: .Testing, dependencies: testingDependency + [
                .userInterface(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.userInterface(target: type, type: .Tests, dependencies: testsDependency + [
                .userInterface(.Feature, for: type),
                .userInterface(.Testing, for: type)
            ]))
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
            let target = Target.userInterface(
                target: type,
                type: .Example,
                infoPlist: infoPlist,
                dependencies: exampleDependency + [
                    .userInterface(.Feature, for: type)
                ]
            )
            
            targets.append(target)
        }
        
        return .makeProject(
            name: type.rawValue,
            targets: targets
        )
    }
    
    static func makeDIContainer(
        type: ModulePaths.DIContainer,
        packages: [Package] = [],
        include: Set<MicroModule>,
        additionalTarget: [Target] = [],
        interfaceDependency: [TargetDependency] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = []
    ) -> Self {
        
        var targets = additionalTarget
        
        if include.contains(.Interface) {
            targets.append(.dIContainer(target: type, type: .Interface, dependencies: []))
        }
        
        if include.contains(.Feature) {
            targets.append(.dIContainer(target: type, type: .Feature, dependencies: featureDependency + [
                .dIContainer(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Testing) {
            targets.append(.dIContainer(target: type, type: .Testing, dependencies: testingDependency + [
                .dIContainer(.Interface, for: type)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.dIContainer(target: type, type: .Tests, dependencies: testsDependency + [
                .dIContainer(.Feature, for: type),
                .dIContainer(.Testing, for: type)
            ]))
        }
        
        return .makeProject(
            name: type.rawValue,
            targets: targets
        )
    }
}
