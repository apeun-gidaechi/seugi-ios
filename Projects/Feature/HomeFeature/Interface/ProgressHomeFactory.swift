import SwiftUI

public protocol ProgressHomeFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
