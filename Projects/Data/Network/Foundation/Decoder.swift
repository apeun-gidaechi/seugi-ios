import Foundation

import DateUtil

public let decoder = JSONDecoder().then { decoder in
    let localDateTimeMSFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
    let localDateTimeFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss")
    let localDateFormatter = DateFormatter("yyyy-MM-dd")
    
    decoder.dateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        var dateStr = try container.decode(String.self)
        
        if dateStr.count > 26 {
            dateStr = String(dateStr[0..<26])
        }
        
        return if let date = localDateTimeMSFormatter.date(from: dateStr) {
            date
        } else if let date = localDateTimeFormatter.date(from: dateStr) {
            date
        } else if let date = localDateFormatter.date(from: dateStr) {
            date
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
