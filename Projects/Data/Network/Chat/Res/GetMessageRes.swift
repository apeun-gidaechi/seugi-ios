import Domain
import Foundation

struct GetMessageRes: SeugiResponse {
    let firstMessageId: String?
    let messages: [MessageRes]
    
    func toEntity() -> GetMessage {
        GetMessage(
            firstMessageId: firstMessageId,
            messages: messages.map { $0.toEntity() }
        )
    }
}
