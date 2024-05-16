import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDomain(
    type: .Base,
    include: [.Feature, .Interface],
    interfaceDependency: [
        .shared(.Feature, for: .GlobalThirdPartyLibrary),
        .dIContainer(.Interface, for: .DIContainer),
        .shared(.Feature, for: .DateUtil),
        .shared(.Feature, for: .Secret),
        .core(.Feature, for: .UserDefault),
        .SPM.Moya
    ]
)
