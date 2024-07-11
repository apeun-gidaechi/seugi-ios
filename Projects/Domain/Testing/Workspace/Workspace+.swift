import Domain

extension Workspace: Mock {
    public static func mock() -> Workspace {
        Workspace(
            workspaceId: .randomUUID(),
            workspaceName: "temp workspace name",
            workspaceImageUrl: "",
            workspaceAdmin: 1,
            middleAdmin: [1, 2],
            teacher: [],
            student: []
        )
    }
}
