import Domain

import ApeunStompKit

extension SendStompError {
    func toDomain() -> StompSendErrorEntity {
        StompSendErrorEntity(description: description, message: message)
    }
}
