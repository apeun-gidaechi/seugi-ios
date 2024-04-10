import SwiftUI

public protocol HomeFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
