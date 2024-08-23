import SwiftUI

public protocol RootFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
