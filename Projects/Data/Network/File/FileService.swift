import Foundation
import Domain

final class FileService: FileRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }

    func upload(type: FileType, file: Data) -> APIResult<Base<File>> {
        runner.deepDive(FileEndpoint.upload(type: type, file: file), res: Base<File>.self)
    }
}
