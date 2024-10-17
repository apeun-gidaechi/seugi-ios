import Foundation
import DateUtil

public extension JSONEncoder {
    static var myEncoder: JSONEncoder {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .custom { date, encoder in
            let dateStr = DateFormatter(type: .isoDateTimeMilliSec).string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(dateStr)
        }
        return e
    }
}
