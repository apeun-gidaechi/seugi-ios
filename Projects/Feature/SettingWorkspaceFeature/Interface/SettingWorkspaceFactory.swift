import SwiftUI

public protocol SettingWorkspaceFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
