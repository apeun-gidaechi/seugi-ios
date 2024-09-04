//import Domain
//import RealmSwift
//
//final class LocalChatService: LocalChatRepo {
//    func insertGroup(workspaceId: String, room: Domain.Room) throws {
//        let realm = try Realm()
//        try realm.write {
//            realm.add(
//                LocalRoom.of(workspaceId: workspaceId, room: room)
//            )
//        }
//    }
//    
//    func getGroupAll(workspaceId: String) throws -> [Domain.Room] {
//        let realm = try Realm()
//        let rooms = realm.objects(LocalRoom.self)
//        return rooms.map { $0.toRoom() }
//    }
//    
//    func removeGroupAll() throws {
//        let realm = try Realm()
//        let rooms = realm.objects(LocalRoom.self)
//        realm.delete(rooms)
//    }
//}
