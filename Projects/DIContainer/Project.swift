import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "DIContainer",
    targets: [
        .make(
            name: "DIContainer",
            product: .staticFramework,
            bundleId: makeBundleId("DIContainer"),
            sources: ["Sources/**"],
            dependencies: [
                .SPM.Swinject
            ]
        )
    ]
)
