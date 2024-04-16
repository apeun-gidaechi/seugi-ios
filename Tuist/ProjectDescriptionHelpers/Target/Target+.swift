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
        target: ModulePaths.App,
        dependenceis: [TargetDependency] = [],
        infoPlist: InfoPlist,
        entitlements: Entitlements? = nil
    ) -> Self {
        .makeTarget(
            name: "Seugi",
            product: .app,
            bundleId: "com.\(env.name)",
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: entitlements,
            scripts: [.swiftLint],
            dependencies: dependenceis
        )
    }
    
    static func feature(
        target: ModulePaths.Feature,
        type: MicroModule,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)Feature\(type.rawValue)",
            product: type.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())feature\(type.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(type.source)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func domain(
        target: ModulePaths.Domain,
        type: MicroModule,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)Domain\(type.rawValue)",
            product: type.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())domain\(type.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(type.rawValue)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func shared(
        target: ModulePaths.Shared,
        type: MicroModule,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)\(type.rawValue)",
            product: type.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())\(type.rawValue.lowercased())",
            infoPlist: .default,
            sources: ["Sources/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func userInterface(
        target: ModulePaths.UserInterface,
        type: MicroModule,
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)\(type.rawValue)",
            product: type.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())\(type.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(type.source)/**"],
            resources: resources,
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func dIContainer(
        target: ModulePaths.DIContainer,
        type: MicroModule,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)\(type.rawValue)",
            product: type.product,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())\(type.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(type.source)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
}
