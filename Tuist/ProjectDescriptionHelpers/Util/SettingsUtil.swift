import ProjectDescription
import EnvironmentPlugin

public func makeSettings() -> Settings {
    Settings.settings(
        base: ["DEVELOPMENT_TEAM":"B42SPPS3PR"].otherLinkerFlags(["-ObjC"]),
        configurations: [
            .debug(name: .debug, xcconfig: .debugConfig),
            .release(name: .release, xcconfig: .releaseConfig)
        ]
    )
}
