import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Base,
    include: [.Feature, .Interface],
    interfaceDependency: [
        .userInterface(.Feature, for: .DesignSystem),
        .shared(.Feature, for: .GlobalThirdPartyLibrary),
        .shared(.Feature, for: .SwiftUIUtil),
        .dIContainer(.Interface, for: .DIContainer)
    ],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
