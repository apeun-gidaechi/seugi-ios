public struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let code: String
    
    public init(name: String, email: String, password: String, code: String) {
        self.name = name
        self.email = email
        self.password = password
        self.code = code
    }
}
