import SwiftUI

public protocol ChatDetailFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
