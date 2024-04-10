import SwiftUI

public protocol ChatFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
