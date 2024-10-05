import Foundation
import Moya

protocol AIEndpoint: BaseEndpoint {}

extension AIEndpoint {
    var baseURL: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "AIBaseUrl") as? String ?? ""
        print("baseurl - \(baseUrl)")
        return URL(string: baseUrl)!
            .appendingPathComponent(host)
    }
}
