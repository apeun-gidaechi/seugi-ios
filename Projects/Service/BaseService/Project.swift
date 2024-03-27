import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Service.BaseService.rawValue,
    product: .staticLibrary,
    targets: [
        .service(name: ModulePaths.Service.BaseService.rawValue, dependencies: [
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
    ],
    scripts: [.swiftLint]
)
