//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hhhello0507 on 8/23/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let project = Project.make(
    name: "Feature",
    targets: [
        .make(
            name: "Feature",
            product: .staticLibrary,
            bundleId: makeBundleId("Feature"),
            sources: ["Sources/**"],
            dependencies: [
                .domain,
                .component,
                .SPM.GoogleSignIn,
                .SPM.FirebaseMessaging
            ]
        )
    ]
)
