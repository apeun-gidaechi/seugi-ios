import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeFeature(
    type: .Base,
    include: [.Interface],
    interfaceDependency: [
        .diContainer,
        .component
    ]
)
