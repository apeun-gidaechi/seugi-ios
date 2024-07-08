import SwiftUI
import Domain

public protocol ChatDetailFactory {
    associatedtype ViewType: View
    func makeView(room: Room) -> ViewType
}
