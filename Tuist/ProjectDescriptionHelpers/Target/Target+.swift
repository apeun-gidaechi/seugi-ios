//
//  Target+Example.swift
//  Test2Manifests
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import EnvironmentPlugin

public extension Target {
    
    static func app(
        type: ModulePaths.App,
        dependenceis: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil
    ) -> Self {
        let name = "Seugi-\(type.rawValue)"
        return Target.makeTarget(
            name: name,
            product: .app,
            bundleId: "com.\(env.name)",
            infoPlist: infoPlist,
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            entitlements: entitlements,
            scripts: [.swiftLint],
            dependencies: dependenceis
        )
    }
    
    static func feature(
        of target: ModulePaths.Feature,
        module: MicroFeatureModule,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)Feature\(module.rawValue)",
            product: module.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())feature\(module.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(module.source)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func domain(
        name: String = "Domain",
        infoPlist: InfoPlist = .default,
        product: Product = .framework,
        sources: SourceFilesList = ["Sources/**"],
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: name,
            product: product,
            bundleId: "com.\(env.name).\(name.lowercased())",
            infoPlist: infoPlist,
            sources: sources,
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func data(
        target: ModulePaths.Data,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)",
            product: .staticLibrary,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(target.rawValue)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies + [
                .domain,
                .diContainer
            ]
        )
    }
    
    static func shared(
        target: ModulePaths.Shared,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)",
            product: .framework,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(target.rawValue)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func component(
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "Component",
            product: .framework,
            bundleId: "com.\(env.name).\(ModulePaths.Single.Component.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: resources,
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func dIContainer(
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "DIContainer",
            product: .framework,
            bundleId: "com.\(env.name).\(ModulePaths.Single.DIContainer.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
}
