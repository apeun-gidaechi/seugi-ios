import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    type: .Base,
    include: [.Feature, .Interface],
    interfaceDependency: [
        .shared(.Feature, for: .GlobalThirdPartyLibrary),
        .dIContainer(.Interface, for: .DIContainer)
    ]
)
