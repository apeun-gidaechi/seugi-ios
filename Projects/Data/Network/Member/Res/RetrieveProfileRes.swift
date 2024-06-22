import Domain

struct RetrieveProfileRes: SeugiResponse {
    let member: RetrieveMemberRes
    let workspaceId: String
    let status: String
    let nick: String
    let spot: String
    let belong: String
    let phone: String
    let wire: String
    let location: String
    
    func toEntity() -> RetrieveProfile {
        RetrieveProfile(
            member: member.toEntity(),
            workspaceId: workspaceId,
            status: status,
            nick: nick,
            spot: spot,
            belong: belong,
            phone: phone,
            wire: wire,
            location: location
        )
    }
}
