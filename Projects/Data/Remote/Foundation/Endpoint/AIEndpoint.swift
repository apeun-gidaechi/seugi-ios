import Foundation
import Moya

protocol AIEndpoint: BaseEndpoint {}

extension AIEndpoint {
    var baseURL: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "AIBaseUrl") as? String ?? ""
        return URL(string: baseUrl)!
            .appendingPathComponent(host)
    }
}
