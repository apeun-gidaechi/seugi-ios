//
//  Target+makeTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/29/24.
//

import ProjectDescription
import EnvironmentPlugin

extension Target {
    static func makeTarget(
        name: String,
        product: Product,
        bundleId: String,
        infoPlist: InfoPlist,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency]
    ) -> Self {
        .init(name: name,
              destinations: env.destinations,
              product: product,
              bundleId: bundleId,
              deploymentTargets: env.deploymentTargets,
              infoPlist: infoPlist,
              sources: sources,
              resources: resources,
              entitlements: entitlements,
              scripts: scripts,
              dependencies: dependencies,
              settings: .settings(
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ], defaultSettings: .recommended
              )
        )
    }
}
