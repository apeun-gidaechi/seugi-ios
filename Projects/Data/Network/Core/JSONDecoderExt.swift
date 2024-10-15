import Foundation
import DateUtil

public extension JSONDecoder {
    static var myDecoder: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            // If the prefix is ​​0000-, it means online.
            if dateStr.hasPrefix("0001") {
                return Date.distantPast
            }
            
            let dateFormatters = DateFormatterType.allCases
            if let date = dateFormatters.compactMap({ DateFormatter(type: $0).date(from: dateStr) }).first {
                return date
            } else {
                let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
                throw DecodingError.dataCorrupted(context)
            }
        }
        return d
    }
}
