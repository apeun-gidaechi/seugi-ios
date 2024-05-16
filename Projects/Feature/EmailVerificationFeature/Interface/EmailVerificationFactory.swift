import SwiftUI

public protocol EmailVerificationFactory {
    associatedtype ViewType: View
    func makeView(name: String, email: String, password: String) -> ViewType
}
