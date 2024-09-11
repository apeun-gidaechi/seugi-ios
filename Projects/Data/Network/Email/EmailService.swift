import Domain

final class EmailService: Service<EmailEndpoint>, EmailRepo {
    func send(email: String) -> ObservableResult<BaseVoid> {
        performRequest(.send(email: email))
    }
}
