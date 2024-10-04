public protocol LocalChatRepo {
    func insertGroup(workspaceId: String, room: Room) throws
    func getGroupAll(workspaceId: String) throws -> [Room]
    func removeGroupAll() throws
}
