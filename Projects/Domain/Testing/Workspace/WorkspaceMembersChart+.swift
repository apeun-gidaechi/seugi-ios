import Domain

extension WorkspaceMembersChart: Mock {
    public static func mock() -> WorkspaceMembersChart { // TODO: Add mock
        WorkspaceMembersChart(
            teachers: [:],
            students: [:]
        )
    }
}
