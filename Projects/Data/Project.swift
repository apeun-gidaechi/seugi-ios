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
            .SPM.ApeunStompKit,
            .SPM.Then,
            .shared(of: .DateUtil)
        ])
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
