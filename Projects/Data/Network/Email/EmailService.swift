import Domain

final class EmailService: Service, EmailRepo {
    typealias Target = EmailEndpoint
    func send(email: String) -> APIResult<BaseVoid> {
        request(.send(email: email))
            .map { $0.toEntity() }
            .asResult()
    }
}
