import SwiftUI

public protocol WorkspaceDetailFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
