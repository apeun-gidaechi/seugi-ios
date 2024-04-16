import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDIContainer(
    type: .DIContainer,
    include: [.Interface, .Feature],
    interfaceDependency: [
        .SPM.Swinject
    ]
)
