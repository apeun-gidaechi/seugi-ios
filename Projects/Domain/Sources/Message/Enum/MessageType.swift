public enum MessageType: String, RawRepresentable, Encodable {
    case message = "MESSAGE"
    case file = "FILE"
    case image = "IMG"
}
