import Domain
import Foundation

struct GetMessageRes: Decodable {
    let firstMessageId: String?
    let messages: [MessageRes]
}
