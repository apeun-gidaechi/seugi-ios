import Domain
import Foundation

final class FileService: Service<FileEndpoint>, FileRepo {
    func upload(type: FileType, file: Data) -> APIResult<Base<String>> {
        performRequest(.upload(type: type, file: file), res: String.self)
    }
}
