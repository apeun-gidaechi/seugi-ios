import Domain

public final class FakeMessageRepo: MessageRepo {
    public init() {}
    public func getMessages(roomId: String, page: Int, size: Int) -> APIResult<Base<GetMessage>> {
        GetMessage.mock().successBaseResult
    }
}
