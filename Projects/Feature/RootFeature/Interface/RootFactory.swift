import SwiftUI

public protocol RootFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
