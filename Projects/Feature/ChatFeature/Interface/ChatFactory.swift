import SwiftUI
import Domain

public protocol ChatFactory {
    associatedtype ViewType: View
    func makeView(roomType: RoomType) -> ViewType
}
