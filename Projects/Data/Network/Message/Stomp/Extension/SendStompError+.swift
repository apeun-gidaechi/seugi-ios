import Domain

import ApeunStompKit

extension SendStompError {
    func toDomain() -> SendStompErrorEntity {
        SendStompErrorEntity(description: description, message: message)
    }
}
