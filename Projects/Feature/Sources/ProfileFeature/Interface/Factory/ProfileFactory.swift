import SwiftUI

public protocol ProfileFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
