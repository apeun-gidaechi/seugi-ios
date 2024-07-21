public enum OnboardingDestination: Hashable {
    case emailSignUp
    case emailSignIn
    case emailVerification(name: String, email: String, password: String)
    case start
}
