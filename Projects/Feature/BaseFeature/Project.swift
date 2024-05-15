import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeFeature(
    type: .Base,
    include: [.Feature, .Interface],
    interfaceDependency: [
        .userInterface(.Feature, for: .DesignSystem),
        .shared(.Feature, for: .GlobalThirdPartyLibrary),
        .shared(.Feature, for: .SwiftUIUtil),
        .dIContainer(.Interface, for: .DIContainer),
        .shared(.Feature, for: .DateUtil),
        .shared(.Feature, for: .Secret),
        .SPM.Flow,
        .SPM.Nuke
    ]
)
