import Swinject
import SettingProfileFeatureInterface

public final class SettingProfileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any SettingProfileFactory).self) { _ in
            SettingProfileFactoryImpl()
        }
    }
}
