import SwiftUI

public protocol EmailSignUpFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
