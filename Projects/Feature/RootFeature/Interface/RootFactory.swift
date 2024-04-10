import SwiftUI

public protocol RootFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
