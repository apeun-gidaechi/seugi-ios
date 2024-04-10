import SwiftUI

public protocol EmailSignInFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
