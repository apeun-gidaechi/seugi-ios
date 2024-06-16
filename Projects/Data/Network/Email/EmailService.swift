import Domain

final class EmailService: Service<EmailEndpoint>, EmailRepo {
    func send(email: String) -> APIResult<BaseVoid> {
        performRequest(.send(email: email))
    }
}
