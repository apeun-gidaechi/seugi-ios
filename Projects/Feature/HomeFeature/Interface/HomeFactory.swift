import SwiftUI

public protocol HomeFactory {
    associatedtype ViewType: View
    func makeView(flow: HomeFetchFlow) -> ViewType
}
