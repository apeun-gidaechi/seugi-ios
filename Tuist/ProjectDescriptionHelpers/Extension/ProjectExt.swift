import ProjectDescription
import EnvironmentPlugin

public extension Project {
    
    static func make(
        name: String,
        organizationName: String? = env.organizationName,
        options: Project.Options = .options(
            defaultKnownRegions: ["en", "ko"],
            developmentRegion: "ko"
        ),
        packages: [Package] = [],
        settings: Settings? = makeSettings(
            xcconfig: .defaultXCConfig
        ),
        targets: [Target] = [],
        schemes: [Scheme] = [],
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = .default
    ) -> Self {
        Project(
            name: name,
            organizationName: organizationName,
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes + [
                .makeScheme(target: .debug, name: name),
                .makeScheme(target: .release, name: name)
            ],
            fileHeaderTemplate: fileHeaderTemplate,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme.scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
