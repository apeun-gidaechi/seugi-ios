import SwiftUI

public protocol WorkspaceDetailFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
