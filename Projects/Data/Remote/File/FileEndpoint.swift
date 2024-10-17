import Domain
import Foundation
import Moya

enum FileEndpoint {
    case upload(type: FileType, file: Data)
}

extension FileEndpoint: SeugiEndpoint {
    var host: String { "file" }
    var route: Route {
        switch self {
        case .upload(let type, let file):
            let fileType = MultipartFormData(provider: .data(file), name: "file", fileName: "seugi.png")
            return .post("upload/\(type.rawValue)")
                .task(.uploadMultipart([fileType]))
        }
    }
}
