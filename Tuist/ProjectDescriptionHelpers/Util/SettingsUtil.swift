import ProjectDescription
import EnvironmentPlugin

public func makeSettings() -> Settings {
    Settings.settings(
        base: [
            "DEVELOPMENT_TEAM":"B42SPPS3PR",
            "_EXPERIMENTAL_SWIFT_EXPLICIT_MODULES": true,
            "SWIFT_WHOLE_MODULE_OPTIMIZATION": true
        ]
            .otherLinkerFlags(["$(inherited) -ObjC"])
            .otherSwiftFlags(["-Xfrontend -debug-time-function-bodies"]),
        configurations: [
            .debug(
                name: .debug,
                settings: [
                    "SWIFT_ACTIVE_COMPILATION_CONDITIONS":"LOG"
                ],
                xcconfig: .debugConfig
            ),
            .release(name: .release, xcconfig: .releaseConfig)
        ]
    )
}
