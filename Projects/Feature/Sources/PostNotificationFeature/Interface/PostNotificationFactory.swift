import SwiftUI

public protocol PostNotificationFactory {
    associatedtype ContentView: View
    func makeView(type: PostNotificationType) -> ContentView
}
