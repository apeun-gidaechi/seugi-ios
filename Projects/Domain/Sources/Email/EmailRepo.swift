public protocol EmailRepo {
    func send(email: String) -> ObservableResult<BaseVoid>
}
