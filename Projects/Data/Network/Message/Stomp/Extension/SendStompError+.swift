import Domain
import ApeunStompKit

extension SendStompError: EntityMappable {
    func toEntity() -> SendStompErrorEntity {
        SendStompErrorEntity(description: description, message: message)
    }
}
