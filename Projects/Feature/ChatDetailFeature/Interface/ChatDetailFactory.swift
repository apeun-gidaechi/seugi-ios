import SwiftUI

public protocol ChatDetailFactory {
    associatedtype ViewType: View
    func makeView(roomId: String) -> ViewType
}
