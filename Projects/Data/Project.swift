import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeData(
    targets: [
        .data(target: .Core),
        .data(target: .Local),
        .data(target: .Network, dependencies: [
            .SPM.Moya,
            .SPM.CombineMoya,
            .shared(of: .SwiftUtil),
            .shared(of: .GlobalThirdPartyLibrary),
            .shared(of: .DateUtil)
        ])
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
