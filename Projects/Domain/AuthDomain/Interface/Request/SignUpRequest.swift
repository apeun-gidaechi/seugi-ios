public struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let birth: String
    let token: String
}
