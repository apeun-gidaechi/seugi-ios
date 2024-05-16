public struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let token: String
    
    public init(name: String, email: String, password: String, token: String) {
        self.name = name
        self.email = email
        self.password = password
        self.token = token
    }
}
