import Domain

extension RetrieveProfile: Mock {
    public static func mock() -> RetrieveProfile {
        RetrieveProfile(
            member: .mock(),
            workspaceId: .randomUUID(),
            status: "좋아요",
            nick: "닉네임",
            spot: "사무실",
            belong: "",
            phone: "temp phone",
            wire: "temp wire",
            location: "temp location",
            schGrade: 1,
            schClass: 2,
            schNumber: 12
        )
    }
}
