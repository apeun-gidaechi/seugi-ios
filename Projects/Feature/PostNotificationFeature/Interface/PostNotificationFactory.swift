import SwiftUI

public protocol PostNotificationFactory {
    associatedtype ViewType: View
    func makeView(type: PostNotificationType) -> ViewType
}
