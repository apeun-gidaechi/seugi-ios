import Domain

import RealmSwift

final class LocalChatService: LocalChatRepo {
    func insertGroup(workspaceId: String, room: Room) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.add(
                RoomEntity.of(workspaceId: workspaceId, room: room)
            )
        }
    }
    
    func getGroupAll(workspaceId: String) throws -> [Room] {
        let realm = try Realm()
        let rooms = realm.objects(RoomEntity.self)
        return rooms.map { $0.toDomain() }
    }
    
    func removeGroupAll() throws {
        let realm = try Realm()
        let rooms = realm.objects(RoomEntity.self)
        realm.delete(rooms)
    }
}
