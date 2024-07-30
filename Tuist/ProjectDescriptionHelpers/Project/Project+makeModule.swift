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
            configurations: [
                .debug(name: .debug, xcconfig: xcconfig),
                .release(name: .release, xcconfig: xcconfig)
            ], defaultSettings: .recommended
        )
        
        return Project(
            name: name,
            options: .options(
                defaultKnownRegions: ["en", "ko"],
                developmentRegion: "ko"
            ),
            packages: packages,
            settings: settings,
            targets: targets
        )
    }
}
