import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Base,
    targets: [
        .feature(target: .Base, dependencies: [
            .featureInterface(target: .Base),
        ]),
        .featureInterface(target: .Base, dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .SwiftUIUtil),
            .dIContainerInterface(target: .DIContainer)
        ])
    ]
)
