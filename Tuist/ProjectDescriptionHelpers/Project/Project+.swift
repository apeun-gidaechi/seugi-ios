//
//  Project+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/29/24.
//

import ProjectDescription

public extension Project {
    
    /**
     DIContainer
     */
    static func makeDIContainer(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        dependency: [TargetDependency] = []
    ) -> Self {
        .makeProject(
            name: ModulePaths.Single.DIContainer.rawValue,
            packages: packages, targets: [
                .dIContainer(
                    infoPlist: infoPlist,
                    dependencies: dependency
                )
            ]
        )
    }
    
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
    
    /**
     Feature: View와 Adapter 포함
     */
    static func makeFeature(
        type: ModulePaths.Feature,
        packages: [Package] = [],
        include: Set<MicroFeatureModule>,
        additionalTarget: [Target] = [],
        interfaceDependency: [TargetDependency] = [],
        featureDependency: [TargetDependency] = [],
        testingDependency: [TargetDependency] = [],
        testsDependency: [TargetDependency] = [],
        exampleDependency: [TargetDependency] = []
    ) -> Self {
        var targets = additionalTarget
        
        if include.contains(.Interface) {
            targets.append(.feature(of: type, module: .Interface, dependencies: interfaceDependency))
        }
        
        if include.contains(.Feature) {
            targets.append(.feature(of: type, module: .Feature, dependencies: featureDependency + [
                .feature(of: type, module: .Interface),
                .feature(of: .Base)
            ]))
        }
        
        if include.contains(.Testing) {
            targets.append(.feature(of: type, module: .Testing, dependencies: testingDependency + [
                .feature(of: type, module: .Interface)
            ]))
        }
        
        if include.contains(.Tests) {
            targets.append(.feature(of: type, module: .Tests, dependencies: testsDependency + [
                .feature(of: type, module: .Feature),
                .feature(of: type, module: .Testing)
            ]))
        }
        
        if include.contains(.Example) {
            let infoPlist = InfoPlist.extendingDefault(with: [
                "UIUserInterfaceStyle": "Light",
                "LSRequiresIPhoneOS": .boolean(true),
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": .boolean(false)
                ],
                "UILaunchStoryboardName": .string("")
            ])
            let target = Target.feature(of: type, module: .Example, infoPlist: infoPlist, dependencies: exampleDependency + [
                .feature(of: type, module: .Feature)
            ])
            
            targets.append(target)
        }
        
        return .makeProject(
            name: "\(type.rawValue)Feature",
            packages: packages,
            targets: targets
        )
    }
    
    /**
     공통 공유 모듈
     */
    static func makeShared(
        type: ModulePaths.Shared,
        packages: [Package] = [],
        dependency: [TargetDependency] = []
    ) -> Self {
        return .makeProject(
            name: type.rawValue,
            packages: packages,
            targets: [
                .shared(target: type, dependencies: dependency)
            ]
        )
    }
    
    /**
     UI 컴포넌트 모듈
     */
    static func makeComponent(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        dependency: [TargetDependency] = []
    ) -> Self {
        .makeProject(
            name: ModulePaths.Single.Component.rawValue,
            packages: packages,
            targets: [
                .component(
                    infoPlist: infoPlist,
                    resources: resources,
                    dependencies: dependency
                )
            ]
        )
    }
    
    static func makeDomain(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        dependency: [TargetDependency] = []
    ) -> Self {
        .makeProject(
            name: ModulePaths.Single.Domain.rawValue,
            packages: packages,
            targets: [
                .domain(
                    infoPlist: infoPlist,
                    dependencies: dependency
                )
            ]
        )
    }
    
    static func makeData(
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Self {
        .makeProject(
            name: "Data",
            packages: packages,
            targets: targets
        )
    }
}
