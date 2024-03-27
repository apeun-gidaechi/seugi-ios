import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Service.AuthService.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Service.AuthService.rawValue, dependencies: [
            .service(target: .BaseService)
        ])
    ],
    scripts: [.swiftLint]
)
