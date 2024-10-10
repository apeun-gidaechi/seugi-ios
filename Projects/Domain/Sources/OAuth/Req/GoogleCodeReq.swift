import Foundation

public struct GoogleCodeReq: Encodable {
    public let code: String
    public let token: String
    public let platform: String = "IOS"
    
    public init(
        code: String,
        token: String
    ) {
        self.code = code
        self.token = token
    }
}
