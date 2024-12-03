import Foundation
import DateUtil

public extension JSONDecoder {
    static var myDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            // If the prefix is ​​0000- or 0001-, it means online.
            if ["0001", "0000"].contains(where: { dateStr.hasPrefix($0) }) {
                return Date.distantPast
            }
            
            guard let date = DateFormatterType.allCases.compactMap({ DateFormatter(type: $0).date(from: dateStr) }).first else {
                let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
                throw DecodingError.dataCorrupted(context)
            }
            return date
        }
        return decoder
    }
}
