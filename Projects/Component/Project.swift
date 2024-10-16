//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "Component",
    targets: [
        component(
            name: "Component",
            resources: ["Resources/**"],
            dependencies: [
                .SPM.Nuke,
                .SPM.NukeUI,
                .SPM.Flow,
                .SPM.MCEmojiPicker,
                .domain,
                .shared(of: .SwiftUIUtil),
                .shared(of: .SwiftUtil),
                .shared(of: .DateUtil)
            ]
        ),
        component(
            name: "ComponentExample",
            infoPlist: .file(path: "Support/Info.plist"),
            product: .app,
            sources: ["Example/**"],
            dependencies: [
                .component,
                .domainTesting
            ]
        )
    ]
)

func component(
    name: String,
    infoPlist: InfoPlist = .default,
    product: Product = .framework,
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    dependencies: [TargetDependency] = []
) -> Target {
    .make(
        name: name,
        product: product,
        bundleId: makeBundleId(name),
        infoPlist: infoPlist,
        sources: sources,
        resources: resources,
        dependencies: dependencies
    )
}
