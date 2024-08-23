import ProjectDescription

public extension Project {
    
    /**
     DIContainer
     */
    static func makeDIContainer(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        dependency: [TargetDependency] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: ModulePaths.Single.DIContainer.rawValue,
            packages: packages,
            targets: [
                .dIContainer(
                    infoPlist: infoPlist,
                    dependencies: dependency
                )
            ]
        )
    }
    
    static func makeApp(
        packages: [Package] = [],
        targets: [Target] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: "Seugi",
            packages: packages,
            settings: .makeSettings(xcconfig),
            targets: targets
        )
    }
    
    /**
     공통 공유 모듈
     */
    static func makeShared(
        packages: [Package] = [],
        targets: [Target] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: "Shared",
            packages: packages,
            settings: .makeSettings(xcconfig),
            targets: targets
        )
    }
    
    /**
     UI 컴포넌트 모듈
     */
    static func makeComponent(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        dependency: [TargetDependency] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: ModulePaths.Single.Component.rawValue,
            packages: packages,
            targets: [
                .component(
                    infoPlist: infoPlist,
                    resources: resources,
                    dependencies: dependency
                ),
                .component(
                    name: ModulePaths.Single.Component.rawValue + "Example",
                    infoPlist: .file(path: "Support/Info.plist"),
                    product: .app,
                    sources: ["Example/**"],
                    dependencies: [
                        .component,
                        .domainTesting
                    ]
                )
            ]
        )
    }
    
    static func makeDomain(
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        dependency: [TargetDependency] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: ModulePaths.Single.Domain.rawValue,
            packages: packages,
            targets: [
                .domain(
                    infoPlist: infoPlist,
                    dependencies: dependency
                ),
                .domain(
                    name: "DomainTesting",
                    product: .framework,
                    sources: ["Testing/**"]
                )
            ]
        )
    }
    
    static func makeData(
        packages: [Package] = [],
        targets: [Target] = [],
        xcconfig: Path? = nil
    ) -> Self {
        Project(
            name: "Data",
            packages: packages,
            settings: .makeSettings(xcconfig),
            targets: targets
        )
    }
}
