import SwiftBok
import Foundation

@Init()
@Members()
public struct PatchProfileReq: Encodable {
    public let status: String
    public let nick: String
    public let spot: String
    public let belong: String
    public let phone: String
    public let wire: String
    public let location: String
}
