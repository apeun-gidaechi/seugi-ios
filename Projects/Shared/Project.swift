//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "Shared",
    targets: [
        shared(target: .DateUtil),
        shared(target: .SwiftUIUtil),
        shared(target: .SwiftUtil)
    ]
)

func shared(
    target: Modules.Shared,
    dependencies: [TargetDependency] = []
) -> Target {
    .make(
        name: target.rawValue,
        product: .staticFramework,
        bundleId: makeBundleId(target.rawValue),
        sources: ["\(target.rawValue)/**"],
        dependencies: dependencies
    )
}
