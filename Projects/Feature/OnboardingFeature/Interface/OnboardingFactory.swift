public protocol OnboardingFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
