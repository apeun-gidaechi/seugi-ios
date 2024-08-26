import ProjectDescription
import EnvironmentPlugin

public func makeSettings(xcconfig: Path? = nil) -> Settings {
    Settings.settings(
        configurations: [
            .debug(name: .debug, xcconfig: xcconfig),
            .release(name: .release, xcconfig: xcconfig)
        ]
    )
}
