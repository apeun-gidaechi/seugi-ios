import SwiftUI

public protocol CreateGroupChatFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
