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
        .makeTarget(name: target.rawValue,
                    product: .app,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    entitlements: entitlements,
                    scripts: [.swiftLint],
                    dependencies: dependenceis)
    }
    
    static func feature(
        target: ModulePaths.Feature,
        type: MicroModule,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: "\(target.rawValue)Feature\(type.rawValue)",
                    product: .staticLibrary,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)feature\(type.rawValue.lowercased())",
                    infoPlist: infoPlist,
                    sources: ["\(type.source)/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func domain(
        target: ModulePaths.Domain,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: "\(target.rawValue)Domain",
                    product: .staticLibrary,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)domain",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func domainInterface(
        target: ModulePaths.Domain,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: "\(target.rawValue)DomainInterface",
                    product: .framework,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)domaininterface",
                    infoPlist: .default,
                    sources: ["Interface/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func shared(
        target: ModulePaths.Shared,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: target.rawValue,
                    product: .staticFramework,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func userInterface(
        target: ModulePaths.UserInterface,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(name: target.rawValue,
                    product: .staticFramework,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func userInterfaceExample(
        target: ModulePaths.UserInterface,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: "\(target.rawValue)Example",
                    product: .app,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)Example",
                    infoPlist: .extendingDefault(with: [
                        "UIUserInterfaceStyle":"Light",
                        "LSRequiresIPhoneOS":.boolean(true),
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": .boolean(false)
                        ],
                        "UILaunchStoryboardName": .string("")
                    ]),
                    sources: ["Example/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func dIContainer(
        target: ModulePaths.DIContainer,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: target.rawValue,
                    product: .staticLibrary,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
    
    static func dIContainerInterface(
        target: ModulePaths.DIContainer,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(name: "\(target.rawValue)Interface",
                    product: .framework,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: .default,
                    sources: ["Interface/**"],
                    scripts: [.swiftLint],
                    dependencies: dependencies)
    }
}
