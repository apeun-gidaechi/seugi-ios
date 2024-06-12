enum EmailSignUpDestination: Hashable {
    case emailSignIn
    case emailVerification(name: String, email: String, password: String)
}
