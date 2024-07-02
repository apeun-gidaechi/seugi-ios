import SwiftUI

public protocol EmptyHomeFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
