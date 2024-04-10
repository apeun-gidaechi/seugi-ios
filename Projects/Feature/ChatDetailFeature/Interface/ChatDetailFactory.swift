import SwiftUI

public protocol ChatDetailFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
