import SwiftUI

public protocol LaunchScreenFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
