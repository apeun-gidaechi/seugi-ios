import Swinject
import SettingWorkspaceFeatureInterface

public final class SettingWorkspaceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any SettingWorkspaceFactory).self) { _ in
            SettingWorkspaceFactoryImpl()
        }
    }
}
