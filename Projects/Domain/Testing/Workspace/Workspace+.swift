import Domain

extension Workspace: Mock {
    public static func mock() -> Workspace {
        Workspace(
            workspaceId: .randomUUID(),
            workspaceName: "temp workspace name",
            workspaceImageUrl: "https://cdn2.unrealengine.com/cyberpunk-2077-release-date-1920x1080-582173634.jpg",
            workspaceAdmin: 1,
            middleAdmin: [1, 2],
            teacher: [],
            student: []
        )
    }
}
