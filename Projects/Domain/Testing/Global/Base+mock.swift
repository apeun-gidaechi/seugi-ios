import Domain

extension BaseVoid: Mock {
    public static func mock() -> BaseVoid {
        self.mock(status: 200)
    }
    public static func mock(status: Int) -> BaseVoid {
        BaseVoid(
            status: status,
            success: 200..<300 ~= status,
            state: "temp state",
            message: "temp message"
        )
    }
}

public extension Entity {
    func withFakeBase(status: Int = 200) -> Base<Self> {
        Base(
            status: status,
            success: 200..<300 ~= status,
            state: "temp state",
            message: "temp message",
            data: self
        )
    }
}
