import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDIContainer(
    target: .DIContainer,
    targets: [
        .dIContainer(
            target: .DIContainer,
            dependencies: [
                .SPM.Swinject
            ]
        ),
        .dIContainerInterface(
            target: .DIContainer,
            dependencies: [
                .SPM.Swinject
            ]
        )
    ]
)
