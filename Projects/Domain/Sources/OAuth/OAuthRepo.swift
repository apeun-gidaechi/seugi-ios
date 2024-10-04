public protocol OAuthRepo {
    func authenticateGoogle(_ req: GoogleCodeReq) -> APIResult<Base<Token>>
    func connectGoogle(_ req: GoogleCodeReq) -> APIResult<BaseVoid>
}
