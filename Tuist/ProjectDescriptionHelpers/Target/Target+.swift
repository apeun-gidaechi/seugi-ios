import ProjectDescription
import EnvironmentPlugin

public extension Target {
    
    static func app(
        type: ModulePaths.App,
        dependenceis: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil
    ) -> Self {
        let name = "Seugi-\(type.rawValue)"
        return Target.makeTarget(
            name: name,
            product: .app,
            bundleId: "com.\(env.name)",
            infoPlist: infoPlist,
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            entitlements: entitlements,
            scripts: [.swiftLint],
            dependencies: dependenceis
        )
    }
    
    static func domain(
        name: String = ModulePaths.Single.Domain.rawValue,
        infoPlist: InfoPlist = .default,
        product: Product = .framework,
        sources: SourceFilesList = ["Sources/**"],
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: name,
            product: product,
            bundleId: "com.\(env.name).\(name.lowercased())",
            infoPlist: infoPlist,
            sources: sources,
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func data(
        target: ModulePaths.Data,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)",
            product: .staticLibrary,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(target.rawValue)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies + [
                .domain,
                .diContainer
            ]
        )
    }
    
    static func shared(
        target: ModulePaths.Shared,
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: "\(target.rawValue)",
            product: .staticFramework,
            bundleId: "com.\(env.name).\(target.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["\(target.rawValue)/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func component(
        name: String = ModulePaths.Single.Component.rawValue,
        infoPlist: InfoPlist = .default,
        product: Product = .framework,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Self {
        .makeTarget(
            name: name,
            product: product,
            bundleId: "com.\(env.name).\(name.lowercased())",
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
    
    static func dIContainer(
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency]
    ) -> Self {
        .makeTarget(
            name: ModulePaths.Single.DIContainer.rawValue,
            product: .framework,
            bundleId: "com.\(env.name).\(ModulePaths.Single.DIContainer.rawValue.lowercased())",
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            scripts: [.swiftLint],
            dependencies: dependencies
        )
    }
}
