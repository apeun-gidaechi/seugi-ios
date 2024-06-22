import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeFeature(
    type: .Base,
    include: [.Interface],
    interfaceDependency: [
        .diContainer,
        .component,
        .shared(of: .GlobalThirdPartyLibrary),
        .shared(of: .SwiftUIUtil),
        .shared(of: .DateUtil)
    ]
)
