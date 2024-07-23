import SwiftUI

public protocol CreateWorkspaceFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
