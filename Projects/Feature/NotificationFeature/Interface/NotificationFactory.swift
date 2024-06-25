import SwiftUI

public protocol NotificationFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
