import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Base,
    targets: [
        .feature(target: .Base, dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .SwiftUIUtil),
            .dIContainerInterface(target: .DIContainer)
        ]),
        .featureInterface(target: .Base, dependencies: [])
    ]
)
