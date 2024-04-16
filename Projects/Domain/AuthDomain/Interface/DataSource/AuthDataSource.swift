public protocol AuthDataSource {
    func signIn(_ req: SignInRequest) async throws
    func signUp(_ req: SignUpRequest) async throws
    func googleSignIn(_ req: GoogleSignInRequest) async throws
}
