import Foundation

public enum DateFormatterType: String, CaseIterable {
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate = "yyyy-MM-dd"
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mm" i.e. 1997-07-16T19:20
    case isoDateTime = "yyyy-MM-dd'T'HH:mm"
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ss" i.e. 1997-07-16T19:20:30
    case isoDateTimeSec = "yyyy-MM-dd'T'HH:mm:ss"
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
}
