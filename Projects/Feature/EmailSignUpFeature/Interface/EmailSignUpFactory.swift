import SwiftUI

public protocol EmailSignUpFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
