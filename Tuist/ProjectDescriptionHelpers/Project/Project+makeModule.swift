import ProjectDescription
import EnvironmentPlugin

public extension Settings {
    static func makeSettings(_ xcconfig: Path?) -> Settings {
        .settings(
            configurations: [
                .debug(name: .debug, xcconfig: xcconfig),
                .release(name: .release, xcconfig: xcconfig)
            ], defaultSettings: .recommended
        )
    }
}


let option = Project.Options.options(
    defaultKnownRegions: ["en", "ko"],
    developmentRegion: "ko"
)
