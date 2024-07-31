import SwiftUI

public protocol OnboardingFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
