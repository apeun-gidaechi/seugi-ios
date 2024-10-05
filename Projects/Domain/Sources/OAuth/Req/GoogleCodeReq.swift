import Foundation

public struct GoogleCodeReq: Encodable {
    public let code: String
    public init(code: String) {
        self.code = code
    }
}
