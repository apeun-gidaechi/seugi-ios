import Domain

final class EmailService: EmailRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func send(email: String) -> APIResult<BaseVoid> {
        runner.deepDive(EmailEndpoint.send(email: email), res: BaseVoid.self)
    }
}
