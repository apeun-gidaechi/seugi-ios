import ProjectDescription


public extension Project {
    static func makeModule(
        name: String,
        destinations: Destinations = .iOS,
        product: Product,
        organizationName: String = "seugi",
        packages: [Package] = [],
        deploymentTargets: DeploymentTargets? = .iOS("16.4"),
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings: Settings = .settings(
            base: ["OTHER_LDFLAGS": .string("-ObjC"),
                   "ENABLE_USER_SCRIPT_SANDBOXING": .string("No")],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)
        
        let appTarget = Target(name: name,
                               destinations: destinations,
                               product: product,
                               bundleId: "\(organizationName).\(name)",
                               deploymentTargets: deploymentTargets,
                               infoPlist: infoPlist,
                               sources: sources,
                               resources: resources,
                               scripts: scripts,
                               dependencies: dependencies,
                               settings: settings)
        
        let testTarget = Target(name: "\(name)Tests",
                                destinations: .iOS,
                                product: .unitTests,
                                bundleId: "\(organizationName).\(name)Tests",
                                deploymentTargets: deploymentTargets,
                                infoPlist: infoPlist,
                                sources: ["Tests/**"],
                                scripts: scripts,
                                dependencies: [.target(name: name)]
        )
        
        let schemes: [Scheme] = [
            .makeScheme(target: .debug, name: name)
        ]
        
        let targets: [Target] = [
            appTarget,
            testTarget
        ]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
