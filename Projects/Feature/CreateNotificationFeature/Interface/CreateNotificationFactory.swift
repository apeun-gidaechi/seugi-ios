import SwiftUI

public protocol CreateNotificationFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
