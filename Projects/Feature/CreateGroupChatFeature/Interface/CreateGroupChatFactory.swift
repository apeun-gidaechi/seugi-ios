import SwiftUI

public protocol CreateGroupChatFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
