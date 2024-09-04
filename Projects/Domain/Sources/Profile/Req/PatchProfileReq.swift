import Foundation

public struct PatchProfileReq: Encodable {
    public let status: String
    public let nick: String
    public let spot: String
    public let belong: String
    public let phone: String
    public let wire: String
    public let location: String
    
    public init(status: String, nick: String, spot: String, belong: String, phone: String, wire: String, location: String) {
        self.status = status
        self.nick = nick
        self.spot = spot
        self.belong = belong
        self.phone = phone
        self.wire = wire
        self.location = location
    }
}
