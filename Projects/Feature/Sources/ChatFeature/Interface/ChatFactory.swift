import SwiftUI
import Domain

public protocol ChatFactory {
    associatedtype ContentView: View
    func makeView(roomType: RoomType) -> ContentView
}
