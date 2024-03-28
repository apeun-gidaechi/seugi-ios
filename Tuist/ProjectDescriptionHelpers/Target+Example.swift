//
//  Target+Example.swift
//  Test2Manifests
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import EnvironmentPlugin

public extension Target {
    
    static func example(name: String,
                        dependencies: [TargetDependency] = []) -> Self {
        Target(name: "\(name)Example",
               destinations: env.destinations,
               product: .app,
               bundleId: "\(env.organizationName).\(env.name)\(name)Example",
               deploymentTargets: env.deploymentTargets,
               infoPlist: .extendingDefault(with: [
                "UIUserInterfaceStyle":"Light",
                "LSRequiresIPhoneOS":.boolean(true),
                "UIApplicationSceneManifest": [ "UIApplicationSupportsMultipleScenes": .boolean(false)
                                              ],
                "UILaunchStoryboardName": .string("")
               ]),
               sources: ["Example/**"],
               dependencies: dependencies,
               settings: .settings(
                base: env.baseSetting,
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ], defaultSettings: .recommended
               )
        )
    }
    
    static func feature(name: String,
                        dependencies: [TargetDependency] = []) -> Self {
        Target(name: name,
               destinations: env.destinations,
               product: .staticLibrary,
               bundleId: "\(env.organizationName).\(env.name)Feature",
               deploymentTargets: env.deploymentTargets,
               infoPlist: .default,
               sources: ["Sources/**"],
               dependencies: dependencies,
               settings: .settings(
                base: ["OTHER_LDFLAGS": .string("-ObjC")],
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ]
               )
        )
    }
    
    static func service(name: String,
                        dependencies: [TargetDependency] = []) -> Self {
        Target(name: name,
               destinations: env.destinations,
               product: .staticLibrary,
               bundleId: "\(env.organizationName).\(env.name)Service",
               deploymentTargets: env.deploymentTargets,
               infoPlist: .default,
               sources: ["Sources/**"],
               dependencies: dependencies,
               settings: .settings(
                base: ["OTHER_LDFLAGS": .string("-ObjC")],
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ]
               )
        )
    }
    
    static func userInterface(name: String,
                              dependencies: [TargetDependency] = []) -> Self {
        Target(name: name,
               destinations: env.destinations,
               product: .staticLibrary,
               bundleId: "\(env.organizationName).\(env.name)UserInterface",
               deploymentTargets: env.deploymentTargets,
               infoPlist: .default,
               sources: ["Sources/**"],
               resources: ["Resources/**"],
               dependencies: dependencies,
               settings: .settings(
                base: ["OTHER_LDFLAGS": .string("-ObjC")],
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ]
               )
        )
    }
}