import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeData(
    targets: [
        .data(target: .Core, dependencies: [
            .domain,
            .diContainer
        ]),
        .data(target: .Local, dependencies: [
            .domain,
            .diContainer
        ]),
        .data(target: .Network, dependencies: [
            .shared(of: .GlobalThirdPartyLibrary),
            .SPM.Moya,
            .domain,
            .diContainer
        ])
    ]
)
