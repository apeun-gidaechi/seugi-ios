//
//  Target+Example.swift
//  Test2Manifests
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import EnvironmentPlugin

public extension Target {
    
    static func makeApp(
        target: ModulePaths.App,
        dependenceis: [TargetDependency] = [],
        infoPlist: InfoPlist
    ) -> Self {
        .makeTarget(name: target.rawValue,
                    product: .app,
                    bundleId: "\(env.organizationName).\(env.name).\(target.rawValue)",
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftLint],
                    dependencies: dependenceis)
    }
    
    static func makeFeature(
        target: ModulePaths.Feature,
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
    
    static func makeFeatureExample(
        target: ModulePaths.Feature,
        dependencies: [TargetDependency] = []
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
                    dependencies: dependencies)
    }
    
    static func makeService(
        target: ModulePaths.Service,
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
    
    static func makeShared(
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
    
    static func makeUserInterface(
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
    
    static func makeUserInterfaceExample(
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
}
