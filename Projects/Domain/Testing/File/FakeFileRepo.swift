import Domain
import Foundation

public final class FakeFileRepo: FileRepo {
    public init() {}
    public func upload(type: FileType, file: Data) -> APIResult<Base<String>> {
        "".successBaseResult
    }
}
