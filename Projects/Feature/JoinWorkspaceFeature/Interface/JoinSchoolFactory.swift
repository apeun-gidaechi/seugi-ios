import SwiftUI

public protocol JoinWorkspaceFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
