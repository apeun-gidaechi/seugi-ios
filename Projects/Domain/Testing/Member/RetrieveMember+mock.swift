import Domain

extension RetrieveMember: Mock {
    public static func mock() -> RetrieveMember {
        RetrieveMember(
            id: .random(in: 0..<100000),
            email: "hhhello0507@gmail.com",
            birth: "3/10",
            name: "이강현",
            picture: ""
        )
    }
}
