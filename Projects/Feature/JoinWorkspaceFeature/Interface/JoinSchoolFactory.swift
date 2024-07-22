import SwiftUI

public protocol JoinWorkspaceFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
