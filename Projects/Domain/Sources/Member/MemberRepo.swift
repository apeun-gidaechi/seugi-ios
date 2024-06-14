public protocol MemberRepo {
    func edit(picture: String, name: String, birth: String)
    func login(email: String, password: String)
}
