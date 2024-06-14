import SwiftUI

public protocol LaunchScreenFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
