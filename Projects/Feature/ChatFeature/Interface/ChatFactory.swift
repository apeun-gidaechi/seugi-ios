import SwiftUI

public protocol ChatFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
