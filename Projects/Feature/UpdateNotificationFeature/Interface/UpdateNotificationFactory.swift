import SwiftUI

public protocol UpdateNotificationFactory {
    associatedtype ViewType: View
    func makeView(id: Int) -> ViewType
}
