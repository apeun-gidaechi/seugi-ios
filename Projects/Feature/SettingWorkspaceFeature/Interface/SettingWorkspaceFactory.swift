import SwiftUI

public protocol SettingWorkspaceFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
