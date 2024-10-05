import Foundation
import Moya

protocol SeugiEndpoint: BaseEndpoint {}

extension SeugiEndpoint {
    var baseURL: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String ?? ""
        return URL(string: baseUrl)!
            .appendingPathComponent(host)
    }
}
