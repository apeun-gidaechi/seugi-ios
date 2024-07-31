import SwiftUI
import Domain

public protocol ChatDetailFactory {
    associatedtype ContentView: View
    func makeView(room: Room) -> ContentView
}
