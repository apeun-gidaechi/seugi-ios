import SwiftUI

public protocol JoinSuccessFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
