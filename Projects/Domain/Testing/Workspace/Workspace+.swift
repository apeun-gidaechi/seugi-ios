import Domain

extension Workspace: Mock {
    public static func mock() -> Workspace {
        Workspace(
            workspaceId: .randomUUID(),
            workspaceName: "temp workspace name",
            workspaceImageUrl: "",
            studentCount: .randomIn1000(),
            teacherCount: .randomIn100()
        )
    }
}
