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

let project = Project.make(
    name: "Seugi",
    targets: [
        Target.make(
            name: "Seugi-iOS",
            product: .app,
            bundleId: baseBundleId,
            infoPlist: .file(path: "Seugi-iOS/Support/Info.plist"),
            sources: ["Seugi-iOS/Sources/**"],
            resources: ["Seugi-iOS/Resources/**"],
            entitlements: .file(path: "Seugi-iOS/Support/App.entitlements"),
            dependencies: Modules.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer, .feature, .target(name: "Seugi-iOS-Widget")]
        ),
        Target.make(
            name: "Seugi-iOS-Widget",
            product: .appExtension,
            bundleId: makeBundleId("widget"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
                ]
            ]),
            sources: ["Seugi-iOS-Widget/Sources/**"],
            resources: ["Seugi-iOS-Widget/Resources/**"],
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
