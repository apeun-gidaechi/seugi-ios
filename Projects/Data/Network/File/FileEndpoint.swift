import Domain
import Foundation
import Moya

public enum FileEndpoint: SeugiEndpoint {
    case upload(type: FileType, file: Data)
}

public extension FileEndpoint {
    static var provider: MoyaProvider<FileEndpoint> = .init()
    static var authProvider: MoyaProvider<FileEndpoint> = .init()
    
    var host: String {
        "file"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .upload(let type, let file):
            let fileType = MultipartFormData(provider: .data(type.rawValue.data(using: .utf8)!), name: "type")
            return Moya.Method.post - "upload/\(type)" - .uploadMultipart([fileType])
        }
    }
}
