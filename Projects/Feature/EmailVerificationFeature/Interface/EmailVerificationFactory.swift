import SwiftUI

public protocol EmailVerificationFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
