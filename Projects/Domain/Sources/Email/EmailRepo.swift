public protocol EmailRepo {
    func send(email: String) -> APIResult<BaseVoid>
}
