import SwiftUI

public protocol CreateRoomFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
