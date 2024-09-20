import ProjectDescription
import EnvironmentPlugin

public func makeSettings(xcconfig: Path? = nil) -> Settings {
    Settings.settings(
        base: ["DEVELOPMENT_TEAM":"B42SPPS3PR"].otherLinkerFlags(["-ObjC"]),
        configurations: [
            .debug(name: .debug, xcconfig: xcconfig),
            .release(name: .release, xcconfig: xcconfig)
        ]
    )
}
