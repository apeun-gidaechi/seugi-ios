//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let iosName = "Seugi-iOS"
let iosWidgetName = "\(iosName)-Widget"

let project = Project.make(
    name: "Seugi",
    targets: [
        Target.make(
            name: iosName,
            product: .app,
            bundleId: baseBundleId,
            infoPlist: .file(path: "\(iosName)/Support/Info.plist"),
            sources: ["\(iosName)/Sources/**"],
            resources: ["\(iosName)/Resources/**"],
            entitlements: .file(path: "\(iosName)/Support/\(iosName).entitlements"),
            dependencies: Modules.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer, .feature, .target(name: iosWidgetName)]
        ),
        Target.make(
            name: iosWidgetName,
            product: .appExtension,
            bundleId: makeBundleId("widget"),
            infoPlist: .file(path: "\(iosWidgetName)/Support/Info.plist"),
            sources: ["\(iosWidgetName)/Sources/**"],
            resources: ["\(iosWidgetName)/Resources/**"],
            entitlements: .file(path: "\(iosWidgetName)/Support/\(iosWidgetName).entitlements"),
            dependencies: Modules.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer, .component]
        ),
        Target.make(
            name: "Aggregate",
            product: .bundle,
            bundleId: "\(baseBundleId).aggregate",
            scripts: [.periphery, .swiftLint]
        )
    ]
)
