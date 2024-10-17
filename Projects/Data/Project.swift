import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvironmentPlugin

let project = Project.make(
    name: "Data",
    targets: [
        data(target: .Core, dependencies: [
            .shared(of: .SwiftUIUtil),
            .shared(of: .SwiftUtil),
            .shared(of: .DateUtil)
        ]),
        data(target: .Local, dependencies: [
            .SPM.RealmSwift,
            .SPM.Realm,
            .SPM.ScopeKit,
            .shared(of: .SwiftUIUtil),
            .shared(of: .SwiftUtil),
            .shared(of: .DateUtil)
        ]),
        data(target: .Remote, dependencies: [
            .SPM.Moya,
            .SPM.CombineMoya,
            .SPM.ApeunStompKit,
            .SPM.ScopeKit,
            .shared(of: .SwiftUIUtil),
            .shared(of: .SwiftUtil),
            .shared(of: .DateUtil)
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
