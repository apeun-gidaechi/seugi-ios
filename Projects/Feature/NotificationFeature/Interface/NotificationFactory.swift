import SwiftUI

public protocol NotificationFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
