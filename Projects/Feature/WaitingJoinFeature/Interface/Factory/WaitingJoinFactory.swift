import SwiftUI

public protocol WaitingJoinFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
