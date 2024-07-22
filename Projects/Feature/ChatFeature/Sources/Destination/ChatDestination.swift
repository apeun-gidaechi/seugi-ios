import Domain

enum ChatDestination: Hashable {
    case chatDetail(room: Room)
    case createGroupChat
}
