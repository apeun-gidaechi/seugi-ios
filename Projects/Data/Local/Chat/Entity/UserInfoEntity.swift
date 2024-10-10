import Foundation
import Domain
import RealmSwift

public class UserInfoEntity: Object {
    @Persisted var userInfo: RetrieveMemberEntity
    @Persisted var timestamp: Date
    
    convenience init(userInfo: RetrieveMemberEntity, timestamp: Date) {
        self.init()
        self.userInfo = userInfo
        self.timestamp = timestamp
    }
    
    static func of(_ userInfo: UserInfo) -> UserInfoEntity {
        UserInfoEntity(
            userInfo: RetrieveMemberEntity.of(userInfo.userInfo),
            timestamp: userInfo.timestamp
        )
    }
    
    func toDomain() -> UserInfo {
        UserInfo(
            userInfo: self.userInfo.toDomain(),
            timestamp: self.timestamp
        )
    }
}
