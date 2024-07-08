import ApeunStompKit
import Domain

extension SendStompError: EntityMappable {
    func toEntity() -> SendStompErrorEntity {
        SendStompErrorEntity(description: description, message: message)
    }
}
