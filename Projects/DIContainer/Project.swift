import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDIContainer(
    dependency: [
        .SPM.Swinject
    ]
)
