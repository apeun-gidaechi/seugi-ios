import SwiftUI

public protocol RoomFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
