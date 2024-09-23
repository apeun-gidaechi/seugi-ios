import Domain

public final class FakeMessageRepo: MessageRepo {
    public init() {}
    public func getMessages(roomId: String, page: Int, size: Int) -> ObservableResult<Base<GetMessage>> {
        GetMessage.mock().successBaseResult
    }
}
