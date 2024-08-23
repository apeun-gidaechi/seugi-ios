import SwiftUI

public protocol HomeFactory {
    associatedtype ContentView: View
    func makeView(flow: HomeFetchFlow) -> ContentView
}
