import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    target: .Base,
    targets: [
        .domain(target: .Base, dependencies: [
            .domainInterface(target: .Base)
        ]),
        .domainInterface(
            target: .Base,
            dependencies: [
                .shared(target: .GlobalThirdPartyLibrary),
                .dIContainerInterface(target: .DIContainer)
            ]
        )
    ]
)
