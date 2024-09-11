import Foundation

public protocol FileRepo {
    func upload(type: FileType, file: Data) -> ObservableResult<Base<String>>
}
