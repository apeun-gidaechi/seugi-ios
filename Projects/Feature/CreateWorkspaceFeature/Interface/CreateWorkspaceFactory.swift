import SwiftUI

public protocol CreateWorkspaceFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
