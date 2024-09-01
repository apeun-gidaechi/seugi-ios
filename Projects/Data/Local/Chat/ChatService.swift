import Domain
import RealmSwift

final class ChatService: LocalChatRepo {
    
    var realm: Realm {
        try! Realm()
    }
    
    func insertGroup(workspaceId: String, room: Room) throws {
        try realm.write {
            realm.add(
                LocalRoom.of(workspaceId: workspaceId, room: room)
            )
        }
    }
    
    func getGroupAll(workspaceId: String) -> [Room] {
        let rooms = realm.objects(LocalRoom.self)
        return rooms.map { $0.toRoom() }
    }
    
    func removeGroupAll() {
        let rooms = realm.objects(LocalRoom.self)
        realm.delete(rooms)
    }
}
