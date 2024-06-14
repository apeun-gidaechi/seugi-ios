import Moya
import Foundation

extension Moya.Response {
    func decode<T: Decodable>(of type: T.Type) throws -> T {
        try self
            .map(type, using: JSONDecoder())
    }
}
