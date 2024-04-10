import SwiftUI

public protocol OnboardingFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
