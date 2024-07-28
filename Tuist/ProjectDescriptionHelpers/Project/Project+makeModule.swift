import ProjectDescription
import EnvironmentPlugin

extension Project {
    static func makeProject(
        name: String,
        packages: [Package] = [],
        xcconfig: Path? = nil,
        targets: [Target] = []
    ) -> Project {
        let settings: Settings = .settings(
            base: [
                "OTHER_LDFLAGS": .string("-ObjC"),
                "ENABLE_USER_SCRIPT_SANDBOXING": .string("No"),
                "SKIP_INSTALL": true
            ],
            configurations: [
                .debug(name: .debug, xcconfig: xcconfig),
                .release(name: .release)
            ], defaultSettings: .recommended
        )
        
        let schemes: [Scheme] = [
            .makeScheme(target: .debug, name: name)
        ]
        
        return Project(
            name: name,
            organizationName: env.organizationName, 
            options: .options(
                defaultKnownRegions: ["en", "ko"],
                developmentRegion: "ko"
            ),
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
            runAction: .runAction(
                configuration: target,
                arguments: .init(launchArguments: [
                    .init(name: "IDEPreferLogStreaming", isEnabled: true)
                ])
            ),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
