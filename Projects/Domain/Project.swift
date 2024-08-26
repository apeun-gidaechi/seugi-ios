import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "Domain",
    targets: [
        .make(
            name: "Domain",
            product: .framework,
            bundleId: makeBundleId("Domain"),
            sources: ["Sources/**"],
            dependencies: [
                .SPM.SwiftBok,
                .shared(of: .DateUtil),
                .shared(of: .SwiftUtil)
            ]
        ),
        .make(
            name: "DomainTesting",
            product: .framework,
            bundleId: makeBundleId("DomainTesting"),
            sources: ["Testing/**"]
        )
    ]
)
