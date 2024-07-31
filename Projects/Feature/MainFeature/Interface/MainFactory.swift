import SwiftUI

public protocol MainFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
