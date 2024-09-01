import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "Data",
    targets: [
        data(target: .Core),
        data(target: .Local, dependencies: [
            .SPM.RealmSwift,
            .SPM.Then
        ]),
        data(target: .Network, dependencies: [
            .SPM.Moya,
            .SPM.CombineMoya,
            .SPM.ApeunStompKit,
            .SPM.Then
        ])
    ]
)

func data(
    target: Modules.Data,
    dependencies: [TargetDependency] = []
) -> Target {
    .make(
        name: target.rawValue,
        product: .staticFramework,
        bundleId: makeBundleId(target.rawValue),
        sources: ["\(target.rawValue)/**"],
        dependencies: dependencies + [
            .domain,
            .diContainer
        ]
    )
}
