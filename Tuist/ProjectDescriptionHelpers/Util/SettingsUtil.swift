import ProjectDescription
import EnvironmentPlugin

public func makeSettings() -> Settings {
    Settings.settings(
        base: ["DEVELOPMENT_TEAM":"B42SPPS3PR"]
            .otherLinkerFlags(["$(inherited) -ObjC"]),
        configurations: [
            .debug(
                name: .debug,
                settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS":"LOG"],
                xcconfig: .debugConfig
            ),
            .release(name: .release, xcconfig: .releaseConfig)
        ]
    )
}
