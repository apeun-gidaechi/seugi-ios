import SwiftUI

public protocol OAuthSignUpFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
