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
            .SPM.Moya,
            .SPM.CombineMoya,
            .domain,
            .diContainer,
            .shared(of: .SwiftUtil),
            .shared(of: .GlobalThirdPartyLibrary),
            .shared(of: .DateUtil)
        ])
    ]
)
