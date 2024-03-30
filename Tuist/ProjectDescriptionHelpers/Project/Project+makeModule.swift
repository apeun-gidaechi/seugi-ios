import ProjectDescription
import EnvironmentPlugin



extension Project {
    static func makeProject(
        name: String,
        product: Product,
        packages: [Package] = [],
        targets: [Target] = []
    ) -> Project {
        let settings: Settings = .settings(
            base: ["OTHER_LDFLAGS": .string("-ObjC"),
                   "ENABLE_USER_SCRIPT_SANDBOXING": .string("No")].merging(env.baseSetting),
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended
        )
        
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
