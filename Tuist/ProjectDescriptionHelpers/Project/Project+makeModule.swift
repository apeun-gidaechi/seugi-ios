import ProjectDescription
import EnvironmentPlugin



extension Project {
    static func makeProject(
        name: String,
        product: Product,
        packages: [Package] = [],
        targets: [Target] = [],
        scripts: [ProjectDescription.TargetScript] = []
    ) -> Project {
        let settings: Settings = .settings(
            base: ["OTHER_LDFLAGS": .string("-ObjC"),
                   "ENABLE_USER_SCRIPT_SANDBOXING": .string("No")].merging(env.baseSetting),
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended
        )
        
//            let appTarget = Target(name: name,
//                                   destinations: env.destinations,
//                                   product: product,
//                                   bundleId: "\(env.organizationName).\(env.name)",
//                                   deploymentTargets: env.deploymentTargets,
//                                   infoPlist: infoPlist,
//                                   sources: sources,
//                                   resources: resources,
//                                   scripts: scripts,
//                                   dependencies: appDependencies,
//                                   settings: settings)
        
        
//        if let testDependencies {
//            let testTarget = Target(name: "\(name)Tests",
//                                    destinations: env.destinations,
//                                    product: .unitTests,
//                                    bundleId: "\(env.organizationName).\(env.name)Tests",
//                                    deploymentTargets: env.deploymentTargets,
//                                    infoPlist: infoPlist,
//                                    sources: ["Tests/**"],
//                                    scripts: scripts,
//                                    dependencies: testDependencies
//            )
//            targets.append(testTarget)
//        }
        
        let schemes: [Scheme] = [
            .makeScheme(target: .debug, name: name)
        ]
        
        return Project(
            name: name,
            organizationName: env.organizationName,
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
