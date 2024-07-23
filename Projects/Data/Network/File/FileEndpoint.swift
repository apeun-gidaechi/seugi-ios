import Domain
import Foundation
import Moya

public enum FileEndpoint: SeugiEndpoint {
    case upload(type: FileType, file: Data)
}

public extension FileEndpoint {
    static var provider = MoyaProvider<FileEndpoint>(session: session)
    static var authProvider = MoyaProvider<FileEndpoint>(session: authSession)
    
    var host: String {
        "file"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .upload(let type, let file):
            let fileType = MultipartFormData(provider: .data(file), name: "file", fileName: "seugi.png")
            return Moya.Method.post - "upload/\(type.rawValue)" - .uploadMultipart([fileType])
        }
    }
}
